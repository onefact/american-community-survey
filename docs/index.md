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
  <h1>Hello, America</h1>
  <h2>Welcome to your Census data! Edit&nbsp;<code style="font-size: 90%;">docs/index.md</code> to change this page.</h2>
  <a href="https://github.com/jaanli/exploring_american_community_survey_data/" target="_blank">80% of visualization is data processing; learn how this data was processed from the Census Bureau!<span style="display: inline-block; margin-left: 0.25rem;">↗︎</span></a>
</div>


```js
import "npm:apache-arrow";
import "npm:parquet-wasm/esm/arrow1.js";
import {ApiHeatmap} from "./components/apiHistogram.js";
import {ApiHistogram} from "./components/apiHistogram.js";
```

```js
const latencyHeatmap = FileAttachment("data/latency-heatmap.parquet").parquet();
const latencyByRouteCanvas = document.createElement("canvas");
```

```js
const latencyHistogram = FileAttachment("data/latency-histogram.parquet").parquet();
const histogramCanvas_new = document.createElement("canvas");
```

```js
const topRoutesPixel = d3.sort(d3.rollups(latencyHeatmap.getChild("route"), (D) => D.length, (d) => d).filter(([d]) => d), ([, d]) => -d).map(([route, count]) => ({route, count}));
const routeColor = Object.assign(Plot.scale({color: {domain: topRoutesPixel.map((d) => d.route)}}), {label: "route"});
const routeSwatch = (route) => html`<span style="white-space: nowrap;"><svg width=10 height=10 fill=${routeColor.apply(route)}><rect width=10 height=10></rect></svg> <span class="small">${route}</span></span>`;
```

```js
const incomeData = FileAttachment("data/income-histogram.parquet").parquet();
const histogramCanvas = document.createElement("canvas");
```


```js
// Assuming modification for categorization based on age
const ageColorMapping = d3.sort(d3.rollups(incomeData.getChild("age"), (D) => D.length, (d) => d).filter(([d]) => d), ([, d]) => -d).map(([age, count]) => ({age, count}));
const ageColor = Object.assign(Plot.scale({color: {domain: ageColorMapping.map((d) => d.age.toString())}}), {label: "age"});
const ageSwatch = (age) => html`<span style="white-space: nowrap;"><svg width=10 height=10 fill=${ageColor.apply(age.toString())}><rect width=10 height=10></rect></svg> <span class="small">${age}</span></span>`;
```


<div class="grid grid-cols-2" style="grid-auto-rows: 504px;">
  <div class="card">
    <h2>Income Distribution by Age</h2>
    ${resize((width) => ApiHistogram(incomeData.getChild("income"), incomeData.getChild("count"), incomeData.getChild("age"), {canvas: histogramCanvas, color: ageColor, width, label: "Income ($)", y1: 0.5, y2: 100_000}))}
  </div>
  <div class="card">
    <h2>Response latency histogram</h2>
    ${resize((width) => ApiHistogram(latencyHistogram.getChild("duration"), latencyHistogram.getChild("count"), latencyHistogram.getChild("route"), {canvas: histogramCanvas_new, color: routeColor, width, label: "Duration (ms)", y1: 0.5, y2: 10_000}))}
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
    Create a <a href="https://observablehq.com/framework/routing">new page</a> by adding a Markdown file (<code>whatever.md</code>) to the <code>docs</code> folder.
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
