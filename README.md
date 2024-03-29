# Visualizing two decades of American Community Survey data from the Census Bureau

Visualizing American Community Survey data on people and households from the Census Bureau.

Example visualization:
* Demo: https://jaanli.github.io/american-community-survey/

Or, 38 million Americans' income over 2 decades:

![high_quality](https://github.com/jaanli/american-community-survey/assets/5317244/e54b7e83-b19e-46b6-b4a5-c861acc2d3c4)


This is an [Observable Framework](https://observablehq.com/framework) project. To start the local preview server, run:

```
yarn dev
```

Then visit <http://localhost:3000> to preview your project.

For more, see <https://observablehq.com/framework/getting-started>.

## Project structure

A typical Framework project looks like this:

```ini
.
├─ docs
│  ├─ components
│  │  └─ timeline.js           # an importable module
│  ├─ data
│  │  ├─ launches.csv.js       # a data loader
│  │  └─ events.json           # a static data file
│  ├─ example-dashboard.md     # a page
│  ├─ example-report.md        # another page
│  └─ index.md                 # the home page
├─ .gitignore
├─ observablehq.config.ts      # the project config file
├─ package.json
└─ README.md
```

**`docs`** - This is the “source root” — where your source files live. Pages go here. Each page is a Markdown file. Observable Framework uses [file-based routing](https://observablehq.com/framework/routing), which means that the name of the file controls where the page is served. You can create as many pages as you like. Use folders to organize your pages.

**`docs/index.md`** - This is the home page for your site. You can have as many additional pages as you’d like, but you should always have a home page, too.

**`docs/data`** - You can put [data loaders](https://observablehq.com/framework/loaders) or static data files anywhere in your source root, but we recommend putting them here.

**`docs/components`** - You can put shared [JavaScript modules](https://observablehq.com/framework/javascript/imports) anywhere in your source root, but we recommend putting them here. This helps you pull code out of Markdown files and into JavaScript modules, making it easier to reuse code across pages, write tests and run linters, and even share code with vanilla web applications.

**`observablehq.config.ts`** - This is the [project configuration](https://observablehq.com/framework/config) file, such as the pages and sections in the sidebar navigation, and the project’s title.

## Command reference

| Command           | Description                                              |
| ----------------- | -------------------------------------------------------- |
| `yarn install`            | Install or reinstall dependencies                        |
| `yarn dev`        | Start local preview server                               |
| `yarn build`      | Build your static site, generating `./dist`              |
| `yarn deploy`     | Deploy your project to Observable                        |
| `yarn clean`      | Clear the local data loader cache                        |
| `yarn observable` | Run commands like `observable help`                      |

## GPT-4 reference

https://chat.openai.com/share/0284945f-996d-4e62-85c5-bdc0f4e68e18

## Making GIFs for demos

1. Use Quicktime Player to record a screen recording.
2. Use `ffmpeg` to trim the recording:
```sh
ffmpeg -ss 00:00:03 -to 00:00:08 -i recording.mov -c copy trimmed_recording.mov
```
3. Use `ffmpeg` to convert the trimmed recording to a GIF:
```sh
ffmpeg -i trimmed_recording.mov -vf "fps=20,scale=1080:-1:flags=lanczos,palettegen=stats_mode=diff" -y palette.png
ffmpeg -i trimmed_recording.mov -i palette.png -filter_complex "fps=20,scale=1080:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y high_quality.gif
```