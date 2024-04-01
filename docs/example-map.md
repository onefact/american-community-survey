---
title: Example map
---

# Leaflet Examples

[Observable Framework](https://observablehq.com/framework/) is an open source static site generator for data apps.

[Protomaps](https://github.com/protomaps) is an [open source](https://protomaps.com/blog/open-core-to-open-source/) static site generator for maps.

Let's use them together!

```js
import * as L from "npm:leaflet";
import * as protomapsL from "npm:protomaps-leaflet@2.0.1";
```


# Basic: API

Just a sharp basemap built from OpenStreetMap, using Leaflet, with vector tiles loaded from [api.protomaps.com (API key required).](https://protomaps.com/other)

```js
const center = [38,-100];
const zoom = 4;
```

```js
const div = display(document.createElement("div"));
div.style = "height: 400px;";
const map = L.map(div).setView(center,zoom);
var layer = protomapsL.leafletLayer({url:'https://api.protomaps.com/tiles/v3/{z}/{x}/{y}.mvt?key=1003762824b9687f',theme:'light'})
layer.addTo(map);
```

# Basic: No API

The same map, but reading from a [single PMTiles basemap archive](https://beta.source.coop/repositories/protomaps/openstreetmap/description/) hosted on [Source Cooperative](https://source.coop). No API keys needed, no tileserver needed! CORS required, though. Each tile is loaded via HTTP Range Requests.

```js
const div = display(document.createElement("div"));
div.style = "height: 400px;";
const map = L.map(div).setView(center,zoom);
var layer = protomapsL.leafletLayer({url:'https://data.source.coop/protomaps/openstreetmap/tiles/v3.pmtiles', theme:'light'})
layer.addTo(map);
```

# Themes

Client-side rendered map means we can have... dark mode!

```js
const div = display(document.createElement("div"));
div.style = "height: 400px;";
const map = L.map(div).setView(center,zoom);
var layer = protomapsL.leafletLayer({url:'https://api.protomaps.com/tiles/v3/{z}/{x}/{y}.mvt?key=1003762824b9687f', theme:'dark'})
layer.addTo(map);
```

# Tiled Data Loading

Overlaying a 20 megabyte PMTiles archive in the Observable Framework's `data/` dir. Each tile is loaded via HTTP Range Requests.

```js
const areas = FileAttachment("data/cb_2018_us_zcta510_500k_nolimit.pmtiles");
```

```js
const div = display(document.createElement("div"));
div.style = "height: 400px;";
const map = L.map(div).setView(center,zoom);
var baseLayer = protomapsL.leafletLayer({url:'https://api.protomaps.com/tiles/v3/{z}/{x}/{y}.mvt?key=1003762824b9687f', theme:'black'})
baseLayer.addTo(map);
var layer = protomapsL.leafletLayer({url:areas._url, maxDataZoom:7, paintRules: [
  {
      dataLayer: "zcta",
      symbolizer: new protomapsL.PolygonSymbolizer({
          fill:"steelblue",
          opacity: 1,
          width: 0.2,
          stroke: "cyan"
      })
  }
]})
layer.addTo(map);
```

# Interaction: MapLibre GL JS

[MapLibre GL JS](https://maplibre.org) is more advanced than leaflet. Use it if you require:

* Transparent overlay layers
* Smooth, continuous zoom
* Feature interaction with popups and hover states

```js
import maplibregl from "npm:maplibre-gl@4.0.2";
import { PMTiles, Protocol } from "npm:pmtiles@3.0.3";
const protocol = new Protocol();
maplibregl.addProtocol("pmtiles",protocol.tile);
```

<link rel="stylesheet" type="text/css" href="https://unpkg.com/maplibre-gl@4.0.2/dist/maplibre-gl.css">

```js
const div = display(document.createElement("div"));
div.style = "height: 400px;";
const map = new maplibregl.Map({
  container: div,
  zoom: zoom - 1,
  center: [center[1],center[0]],
  style: "https://api.protomaps.com/styles/v2/black.json?key=1003762824b9687f"
})

map.on("load", () => {
  map.addSource("zcta", {
      type: "vector",
      url: `pmtiles://${areas._url}`
  })

  map.addLayer({
    "id":"zcta",
    "source": "zcta",
    "source-layer":"zcta",
    "type": "fill",
    "paint": {
        "fill-color": [
          "case",
          ['boolean', ['feature-state', 'hover'], false],
          "red",
          "steelblue"
        ],
        "fill-opacity": 0.7
    }
  })

  map.addLayer({
    "id":"zcta_stroke",
    "source": "zcta",
    "source-layer":"zcta",
    "type": "line",
    "paint": {
        "line-color": "cyan",
        "line-width": 0.2
    }
  })

  let hoveredId = null;

  const popup = new maplibregl.Popup({
      closeButton: false,
      closeOnClick: false
  });

  map.on('mousemove', 'zcta', (e) => {

      if (e.features.length > 0) {
          map.getCanvas().style.cursor = 'pointer';
          const props = e.features[0].properties;
          let result = '';
          for (let key in props) {
            if (props.hasOwnProperty(key)) {
              result += key + ': ' + props[key] + '<br/>';
            }
          }
          popup.setLngLat(e.lngLat).setHTML(result).addTo(map);

          if (hoveredId) {
              map.setFeatureState(
                  {source: 'zcta', sourceLayer: "zcta", id: hoveredId},
                  {hover: false}
              );
          }
          hoveredId = e.features[0].id;
          map.setFeatureState(
              {source: 'zcta', sourceLayer: "zcta", id: hoveredId},
              {hover: true}
          );
      }
  });

  map.on('mouseleave', 'zcta', () => {
      map.getCanvas().style.cursor = '';
      popup.remove();

      if (hoveredId) {
          map.setFeatureState(
              {source: 'zcta', sourceLayer: "zcta", id: hoveredId},
              {hover: false}
          );
      }
      hoveredId = null;
  });
})
```
