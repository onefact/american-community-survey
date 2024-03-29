---
toc: false
---

```js
import {DuckDBClient} from "npm:@observablehq/duckdb";
const db = DuckDBClient.of({data: FileAttachment("../data/income-histogram-historical-new-york-area-by-race.parquet")});
```

```js
const uniqueYears = await db.query("SELECT DISTINCT year FROM data WHERE year BETWEEN 2005 AND 2022 ORDER BY year").then(data => data.map(d => d.year));
const yearRange = [uniqueYears[0], uniqueYears[uniqueYears.length - 1]];
const yearInput = Inputs.range(yearRange, {
  step: 1,
  value: uniqueYears[0],
  width: 150,
  validate: (input) => input.value !== "2020"
});
const selectedYear = Generators.input(yearInput);
yearInput.querySelector("input[type=number]").remove();
```


```js
// Hardcoded state code to state name mapping
const stateCodeToName = {
  '09': 'Connecticut',
  '34': 'New Jersey',
  '36': 'New York',
  '42': 'Pennsylvania',
  '44': 'Rhode Island'
};

// Fetch PUMA details, including state names based on the hardcoded map
const pumaDetails = await db.query(`
  SELECT DISTINCT puma, puma_name, state_code
  FROM data
`).then(data => data.map(d => ({
  puma: d.puma,
  stateCode: d.state_code,
  label: `${stateCodeToName[d.state_code]} - ${d.puma_name.replace("PUMA", "").trim()}`
})));

console.log("PUMA Details:", pumaDetails);

// Sort pumaDetails alphabetically by state name and then by PUMA name
pumaDetails.sort((a, b) => {
  const stateCompare = stateCodeToName[a.stateCode].localeCompare(stateCodeToName[b.stateCode]);
  if (stateCompare !== 0) return stateCompare;
  return a.label.localeCompare(b.label);
});
```

```js
const PUMAInput = Inputs.select(pumaDetails, {
  label: "Select area",
  value: d => d.puma,
  format: d => d.label
});
const selectedPUMADetails = Generators.input(PUMAInput);
```

```js
const selectedPUMA = selectedPUMADetails.puma;
const selectedStateCode = selectedPUMADetails.stateCode;
```

```js
const mostRecentYear = uniqueYears[uniqueYears.length - 1];
```

```js
const orderRaces = [
  'Other',
  'Two or More',
  'Native Hawaiian and Other Pacific Islander',
  'American Indian or Alaska Native',
  'Asian',
  'Alaska Native',
  'American Indian',
  'Black or African American',
  'White',
];
```

```js
const income = await db.query(`
  SELECT income, count, race FROM data
  WHERE year = ${selectedYear} AND puma = '${selectedPUMA}' AND state_code = '${selectedStateCode}'
`);
```

<!-- ```js
const medianIncome = await db.query(`
  SELECT
    percentile_cont(0.5) WITHIN GROUP (ORDER BY income) AS median_income
  FROM data, generate_series(1, CAST(count AS BIGINT))
  WHERE year = ${selectedYear} AND puma = '${selectedPUMA}' AND state_code = '${selectedStateCode}';
`);
``` -->

```js
function incomeChart(income, width) {
  // Create a histogram with a logarithmic base.
  return Plot.plot({
    width,
    marginLeft: 60,
    x: { type: "log",       domain: [5000, 500000], // Set the domain of the x-axis to be fixed between 1000 and 500,000
     },
    y: { axis: null }, // Hide the y-axis
    color: { legend: "swatches", columns: 1, domain: orderRaces },
    marks: [
      Plot.rectY(
        income,
        Plot.binX(
          { y: "sum" },
          {
            x: "income",
            y: "count",
            fill: "race",
            order: orderRaces,
            thresholds: d3
              .ticks(Math.log10(2_000), Math.log10(1_000_000), 40)
              .map((d) => +(10 ** d).toPrecision(3)),
            tip: true,
          }
        )
      ),
      // Plot.ruleX([medianIncome[0].median_income], {stroke: "red", strokeWidth: 2})
    ],
  });
}
```

<div class="card"> 
<h2>Neighborhood income distributions vary by across time, space, and race</h2>
<h3>How much income per year 15 million people reported earning in the 2005–2022 American Community Survey. This survey is run by the United States' Census Bureau and people are categorized by their self-reported race, specifically for microdata areas overlapping with the New York-Newark-Jersey City core-based statistical area in 2020.</h3>
<h3>
<code style="font-size: 90%;"><a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/f54a1fa6d4b6ed91e3d08815a2f7322b37622855/american_community_survey/models/public_use_microdata_sample/figures/income-histogram-with-sector-historical-with-race-inflation-adjusted-industry-mapped-newyork-newark-cbsa.sql">Code for data transform</a></code></h3>
<div style="display: flex; align-items: center;"> 
<h1 style="margin-top: 0.5rem;">${selectedPUMADetails.label}</h1> ${PUMAInput} </div> 
<div style="display: flex; align-items: center;"> <h1 style="margin-top: 0.5rem;">${selectedYear}</h1> ${yearInput} </div> 
${resize((width) => incomeChart(income, width))} </div> 