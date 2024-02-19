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
  <h2>This is a testbed of visualizing the Census Bureau's American Community Survey data from 2022.  Read about the data &nbsp;<a href="https://www.census.gov/programs-surveys/acs/data.html"><code style="font-size: 90%;">here</code></a> or see how these visualizations were generated <a href="https://github.com/jaanli/american-community-survey/"><code style="font-size: 90%;">on GitHub</code></a>. Ping me on <a href="https://twitter.com/thejaan">Twitter</a> or <a href="mailto:jaan.li@jaan.li">email</a> if you have ideas for <a href="https://github.com/jaanli/exploring_american_community_survey_data/tree/main?tab=readme-ov-file#types-of-data-available-for-every-person-who-responded-to-the-american-community-survey">what other variables</a> in the census to look at or how else to display these millions of datapoints!</h2>
  <a href="https://github.com/jaanli/exploring_american_community_survey_data/" target="_blank">80% of visualization is data processing; learn how this data was processed here!<span style="display: inline-block; margin-left: 0.25rem;">↗︎</span></a>
</div>


```js
import "npm:apache-arrow";
import "npm:parquet-wasm/esm/arrow1.js";
import {ApiHistogram} from "./components/apiHistogram.js";
```


```js
const incomeHistogram = FileAttachment("data/income-histogram.parquet").parquet();
const incomeCanvas = document.createElement("canvas");
```

```js
// Assuming modification for categorization based on sector
const sectorColorMapping = d3.sort(d3.rollups(incomeHistogram.getChild("sector"), (D) => D.length, (d) => d).filter(([d]) => d), ([, d]) => -d).map(([sector, count]) => ({sector, count}));
const sectorColor = Object.assign(Plot.scale({color: {domain: sectorColorMapping.map((d) => d.sector)}}), {label: "sector"});
const sectorSwatch = (sector) => html`<span style="white-space: nowrap;"><svg width=10 height=10 fill=${sectorColor.apply(sector)}><rect width=10 height=10></rect></svg> <span class="small">${sector}</span></span>`;
```

```js
// Import the rent histogram data from the parquet file
const rentHistogram = FileAttachment("data/rent-histogram.parquet").parquet();
const rentCanvas = document.createElement("canvas");
```

```js
// Create the color mapping for regions
const regionColorMapping = d3.sort(d3.rollups(rentHistogram.getChild("region"), (D) => D.length, (d) => d).filter(([d]) => d), ([, d]) => -d).map(([region, count]) => ({ region, count }));
const regionColor = Object.assign(Plot.scale({ color: { domain: regionColorMapping.map((d) => d.region) } }), {label: "region" });
const regionSwatch = (region) => html`<span style="white-space: nowrap;"><svg width=10 height=10 fill=${regionColor.apply(region)}><rect width=10 height=10></rect></svg><span class="small">${region}</span></span>`;
```


<div class="grid grid-cols-2" style="grid-auto-rows: 504px;">
  <div class="card">
    <h2>Income distribution by sector (<a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/income-histogram-with-sector.sql">code</a> for data transform)</h2>
    ${resize((width) => ApiHistogram(incomeHistogram.getChild("income"), incomeHistogram.getChild("count"), incomeHistogram.getChild("sector"), {canvas: incomeCanvas, color: sectorColor, width, label: "Income ($)", y1: 1_000, y2: 200_000}))}
  </div>
  <div class="card">
    <h2>Rent Distribution by Region (<a href="https://github.com/jaanli/exploring_american_community_survey_data/blob/main/american_community_survey/models/public_use_microdata_sample/household-histogram-with-region.sql">code</a> for data transform)</h2>
    ${resize((width) => ApiHistogram(rentHistogram.getChild("rent"), rentHistogram.getChild("count"), rentHistogram.getChild("region"), {canvas: rentCanvas, color: regionColor, width, label: "Rent ($)", y1: 100, y2: 20_000 }))}
  </div>
</div>

---
<!-- 
## Next steps

Here are some ideas of things you could try…

<div class="grid grid-cols-4">
  <div class="card">
    Chart your own data using <a href="https://observablehq.com/framework/lib/plot"><code>Plot</code></a> and <a href="https://observablehq.com/framework/javascript/files"><code>FileAttachment</code></a>. Make it responsive using <a href="https://observablehq.com/framework/javascript/display#responsive-display"><code>resize</code></a>.
  </div>
  <div class="card">
    Create a <a href="https://observablehq.com/framework/routing">new psector</a> by adding a Markdown file (<code>whatever.md</code>) to the <code>docs</code> folder.
  </div>
  <div class="card">
    Add a drop-down menu using <a href="https://observablehq.com/framework/javascript/inputs"><code>Inputs.select</code></a> and use it to filter the data shown in a chart.
  </div>
  <div class="card">
    Write a <a href="https://observablehq.com/framework/loaders">data loader</a> that queries a local database or API, generating a data snapshot on build.
  </div>
  <div class="card">
    Import a <a href="https://observablehq.com/framework/javascript/imports">recommended library</a> from npm, such as <a href="https://observablehq.com/framework/lib/leaflet">Leaflet</a>, <a href="https://observablehq.com/framework/lib/dot">GraphViz</a>, <a href="https://observablehq.com/framework/lib/tex">TeX</a>, or <a href="https://observablehq.com/framework/lib/duckdb">DuckDB</a>.
  </div>
  <div class="card">
    Ask for help, or share your work or ideas, on the <a href="https://talk.observablehq.com/">Observable forum</a>.
  </div>
  <div class="card">
    Visit <a href="https://github.com/observablehq/framework">Framework on GitHub</a> and give us a star. Or file an issue if you’ve found a bug!
  </div>
</div> -->
