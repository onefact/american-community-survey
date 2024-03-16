---
toc: false
---

```js
import {DuckDBClient} from "npm:@observablehq/duckdb";
const db = DuckDBClient.of({data: FileAttachment("data/income-histogram-historical-new-york-area.parquet")});
```

```js
const uniqueYears = await db.query("SELECT DISTINCT year FROM data WHERE year BETWEEN 2010 AND 2022 ORDER BY year").then(data => data.map(d => d.year));
const yearRange = [uniqueYears[0], uniqueYears[uniqueYears.length - 1]];
const yearInput = Inputs.range(yearRange, {step: 1, value: uniqueYears[0], width: 150});
const selectedYear = Generators.input(yearInput);
yearInput.querySelector("input[type=number]").remove();
```

```js
const uniquePUMAs = await db.query(`
  SELECT DISTINCT puma FROM data
  WHERE year = 2020
`).then(data => data.map(d => d.puma));
```

```js
const uniquePUMAs = await db.query("SELECT DISTINCT puma FROM data WHERE year = 2020").then(data => data.map(d => d.puma));
const selectedPUMA = Inputs.select(uniquePUMAs, {label: "Select PUMA", value: uniquePUMAs[0]});
```

```js
const orderSectors = Generators.observe(change => {
  const mostRecentYear = uniqueYears[uniqueYears.length - 1];
  const query = `
    SELECT sector, SUM(income * count) / SUM(count) AS mean_income
    FROM data
    WHERE year = ${mostRecentYear} AND puma = '${selectedPUMA}'
    GROUP BY sector
    ORDER BY mean_income DESC
  `;
  db.query(query).then(data => change(data.map(d => d.sector)));
});
```

```js
const income = Generators.observe((change) => {
  const query = `
    SELECT income, count, sector FROM data
    WHERE year = ${selectedYear} AND puma = '${selectedPUMA}'
  `;
  db.query(query).then(change);
});
```

```js
function incomeChart(income, width) {
  // Create a histogram with a logarithmic base.
  return Plot.plot({
    width,
    marginLeft: 60,
    x: { type: "log" },
    y: { axis: null }, // Hide the y-axis
    color: { legend: "swatches", columns: 6, domain: orderSectors },
    marks: [
      Plot.rectY(
        income,
        Plot.binX(
          { y: "sum" },
          {
            x: "income",
            y: "count",
            fill: "sector",
            order: orderSectors,
            thresholds: d3
              .ticks(Math.log10(2_000), Math.log10(1_000_000), 40)
              .map((d) => +(10 ** d).toPrecision(3)),
            tip: true,
          }
        )
      ),
    ],
  });
}
```

<div class="card">
  <h2>The sectors in which people earn the most money have shifted over the past two decades</h2>
  <h3>How much income per year x million people reported earning in the 2000–2022 American Community Surveys run by the United States' Census Bureau, categorized by their sector of employment, specifically for PUMAs overlapping with the New York-Newark CBSA in 2020.</h3>
  <h3><code style="font-size: 90%;"><a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/figures/income-histogram-with-sector-historical-inflation-adjusted-industry-mapped.sql">Code for data transform</a></code></h3>
  <div style="display: flex; align-items: center;">
    <h1 style="margin-top: 0.5rem;">${selectedYear}</h1>
    ${yearInput}
    ${selectedPUMA}
  </div>
  ${resize((width) => incomeChart(income, width))}
</div>
