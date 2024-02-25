---
toc: false
---

<style>

.hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-family: var(--sans-serif);
  margin: 4rem 0 8rem;
  text-wrap: balance;
  text-align: center;
}

.hero h1 {
  margin: 2rem 0;
  max-width: none;
  font-size: 14vw;
  font-weight: 900;
  line-height: 1;
  background: linear-gradient(30deg, var(--theme-foreground-focus), currentColor);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero h2 {
  margin: 0;
  max-width: 34em;
  font-size: 20px;
  font-style: initial;
  font-weight: 500;
  line-height: 1.5;
  color: var(--theme-foreground-muted);
}

@media (min-width: 640px) {
  .hero h1 {
    font-size: 90px;
  }
}

</style>

<div class="hero">
  <h1>American Community Survey</h1>
</div>

This is a testbed of visualizing the Census Bureau's American Community Survey data. Read about the data &nbsp;<a href="https://www.census.gov/programs-surveys/acs/data.html"><code style="font-size: 90%;">here</code></a> or see how these visualizations were generated <a href="https://github.com/jaanli/american-community-survey/"><code style="font-size: 90%;">on GitHub</code></a> if you want to edit these or make your own; there are thousands of variables and millions of peoples' and households' datapoints to choose from! :)

```js
const income = FileAttachment("data/income-histogram.parquet").parquet();
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
const rent = FileAttachment("data/rent-histogram.parquet").parquet();
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

<!-- <div class="grid grid-cols-2" style="grid-auto-rows: 504px;"> -->
<div class="card">
  <h2>People earn very different amounts of money depending on what sector they work in</h2>
  <h3>How much income per year people reported earning in the 2022 American Community Survey, categorized by their sector of employment.</h3>
  <h3><code style="font-size: 90%;"><a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/figures/income-histogram-with-sector.sql">Code for data transform</a></code></h3>
  ${resize((width) => incomeChart(income, width))}
</div>
<div class="card">
  <h2>Households in different regions pay very different amounts of rent every month</h2>
  <h3>Monthly rent reported by households in the American Community Survey in 2022, categorized by region of the United States.</h3>
  <h3><code style="font-size: 90%;"><a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/figures/household-histogram-with-region.sql">Code for data transform</a></code></h3>
  ${resize((width) => rentChart(rent, width))}
</div>
<!-- </div> -->

<div class="small note">This page reënvisions the display of public data for the public good, and is part of an experiment in exploring urban non-private spaces with my partner. The Census Bureau states that "government agencies use these statistics to
help with decision-making and to allocate over
$675 billion each year back to your community"; that "businesses use ACS estimates to inform important strategic decisionmaking" (<a href="https://www.census.gov/content/dam/Census/programs-surveys/acs/about/ACS_Information_Guide.pdf">source</a>); and, we know of several insurance companies, health systems, and real estate developers who also make use of this data for business purposes. 

 Ping me on <a href="https://twitter.com/thejaan">Twitter</a> or <a href="mailto:jaan.li@jaan.li">email</a> if you have ideas for <a href="https://github.com/jaanli/exploring_american_community_survey_data/tree/main?tab=readme-ov-file#types-of-data-available-for-every-person-who-responded-to-the-american-community-survey">what other variables</a> in the census to look at or how else to display these millions of datapoints!
<a href="https://github.com/jaanli/exploring_american_community_survey_data/" target="_blank">80% of visualization is data processing; learn how this data was processed here!<span style="display: inline-block; margin-left: 0.25rem;">↗︎</span></a>.</p>