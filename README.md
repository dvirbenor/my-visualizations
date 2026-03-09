# my-visualizations

Publish Plotly HTML visualizations to GitHub Pages.

## Folder layout

- Put exported Plotly HTML files in [`visualizations/`](/Users/dvir.benor/PycharmProjects/my-visualizations/visualizations).
- The script [`scripts/build-site.sh`](/Users/dvir.benor/PycharmProjects/my-visualizations/scripts/build-site.sh) generates a static site into `dist/` with an auto-created index page.
- GitHub Actions deploys `dist/` to GitHub Pages from the `main` branch.

## One-time setup on GitHub

1. Push this repo to GitHub.
2. In your repo, open `Settings -> Pages`.
3. Under `Build and deployment`, set `Source` to `GitHub Actions`.
4. Ensure your default branch is `main` (or update [deploy-pages.yml](/Users/dvir.benor/PycharmProjects/my-visualizations/.github/workflows/deploy-pages.yml) to your branch).

## Add/update visualizations

1. Export each Plotly chart as an HTML file.
2. Copy files into [`visualizations/`](/Users/dvir.benor/PycharmProjects/my-visualizations/visualizations).
3. Commit and push to `main`.
4. Wait for the `Deploy GitHub Pages` workflow to finish.

Your site URL will be:

- `https://<your-github-username>.github.io/<repo-name>/`

## Local preview

Run:

```bash
./scripts/build-site.sh
open dist/index.html
```
