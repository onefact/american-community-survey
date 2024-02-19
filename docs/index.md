---
toc: false
---

# American Community Survey

This is a testbed of visualizing the Census Bureau's American Community Survey data from 2022. Read about the data &nbsp;<a href="https://www.census.gov/programs-surveys/acs/data.html"><code style="font-size: 90%;">here</code></a> or see how these visualizations were generated <a href="https://github.com/jaanli/american-community-survey/"><code style="font-size: 90%;">on GitHub</code></a>. Ping me on <a href="https://twitter.com/thejaan">Twitter</a> or <a href="mailto:jaan.li@jaan.li">email</a> if you have ideas for <a href="https://github.com/jaanli/exploring_american_community_survey_data/tree/main?tab=readme-ov-file#types-of-data-available-for-every-person-who-responded-to-the-american-community-survey">what other variables</a> in the census to look at or how else to display these millions of datapoints!
<a href="https://github.com/jaanli/exploring_american_community_survey_data/" target="_blank">80% of visualization is data processing; learn how this data was processed here!<span style="display: inline-block; margin-left: 0.25rem;">↗︎</span></a>

```js
const income = FileAttachment("data/income-histogram.parquet").parquet();
const rent = FileAttachment("data/rent-histogram.parquet").parquet();
```

```js
function incomeChart(income, width) {
  // Order the sectors by mean income
  const orderSectors = d3.groupSort(
    income,
    (v) => -d3.sum(v, (d) => d.income * d.count) / d3.sum(v, (d) => d.count),
    (d) => d.sector
  );

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

```js
function rentChart(rent, width) {
  // Order the regions by mean rent
  const orderRegions = d3.groupSort(
    rent,
    (v) => d3.sum(v, (d) => d.rent * d.count) / d3.sum(v, (d) => +d.count),
    (d) => d.region
  );

  // Create a histogram with a logarithmic base.
  return Plot.plot({
    width,
    marginLeft: 60,
    x: { type: "log" },
    color: { legend: "swatches", columns: 6, domain: orderRegions },
    marks: [
      Plot.areaY(
        rent,
        Plot.binX(
          { y: "sum" },
          {
            x: "rent",
            y: "count",
            fill: "region",
            order: orderRegions,
            thresholds: d3
              .ticks(Math.log10(100), Math.log10(10000), 50)
              .map((d) => +(10 ** d).toPrecision(3)),
            tip: true,
            curve: "monotone-x",
          }
        )
      ),
    ],
  });
}
```

<div class="grid grid-cols-2" style="grid-auto-rows: 504px;">
  <div class="card">
    <h2>Income distribution by sector (<a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/income-histogram-with-sector.sql">code</a> for data transform)</h2>
    ${resize((width) => incomeChart(income, width))}
  </div>
  <div class="card">
    <h2>Rent Distribution by Region (<a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/household-histogram-with-region.sql">code</a> for data transform)</h2>
    ${resize((width) => rentChart(rent, width))}
  </div>
</div>
