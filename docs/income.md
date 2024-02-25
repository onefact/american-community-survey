---
toc: false
---

```js
import {DuckDBClient} from "npm:@observablehq/duckdb";
const db = DuckDBClient.of({data: FileAttachment("data/income-histogram-historical.parquet")});
```

```js
const uniqueYears = await db.query("SELECT DISTINCT year FROM data ORDER BY year").then(data => data.map(d => d.year));
const yearRange = [uniqueYears[0], uniqueYears[uniqueYears.length - 1]]; // Min and Max years
const yearInput = Inputs.range(yearRange, {step: 1, value: 0, width: 150});
const selectedYear = Generators.input(yearInput);
yearInput.querySelector("input[type=number]").remove();
```

```js
const mostRecentYear = uniqueYears[uniqueYears.length - 1];
const income = await db.query(`
  SELECT income, count, sector FROM data
  WHERE year = ${mostRecentYear}
`); 
```

```js
// Order the sectors by mean income
const mostRecentYear = uniqueYears[uniqueYears.length - 1];
const orderSectors = await db.query(`
  SELECT sector, SUM(income * count) / SUM(count) AS mean_income
  FROM data
  WHERE year = ${mostRecentYear}
  GROUP BY sector
  ORDER BY mean_income DESC
`).then(data => data.map(d => d.sector));
```

```js
async function incomeChart(db, selectedYear, width) {
  const income = await db.query(`
  SELECT income, count, sector FROM data
  WHERE year = ${selectedYear}
  `); 

  // Create a histogram with a logarithmic base.
  return Plot.plot({
    width,
    marginLeft: 60,
    x: { type: "log" },
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
  <h3>How much income per year people reported earning in the 2000–2022 American Community Surveys, categorized by their sector of employment.</h3>
  <h3><code style="font-size: 90%;"><a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/figures/income-histogram-with-sector-historical-inflation-adjusted-industry-mapped.sql">Code for data transform</a></code></h3>
  <div style="display: flex; align-items: center;">
  <h1 style="margin-top: 0.5rem;">${selectedYear}</h1>
  ${yearInput}
  </div>
  ${resize((width) => incomeChart(db, selectedYear, width))}
</div>
