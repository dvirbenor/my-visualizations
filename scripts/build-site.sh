#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$ROOT_DIR/visualizations"
OUT_DIR="$ROOT_DIR/dist"
INDEX_FILE="$OUT_DIR/index.html"

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

cat > "$INDEX_FILE" <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>My Visualizations</title>
  <style>
    :root {
      --bg: #f6f8fb;
      --card: #ffffff;
      --text: #17202a;
      --muted: #5a6675;
      --accent: #0b6f6a;
      --accent-hover: #095a56;
      --border: #dde4ec;
    }
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: "Avenir Next", Avenir, "Segoe UI", sans-serif;
      background: radial-gradient(circle at top right, #e4f2f1, var(--bg) 35%);
      color: var(--text);
    }
    main {
      max-width: 760px;
      margin: 48px auto;
      padding: 0 18px;
    }
    .card {
      background: var(--card);
      border: 1px solid var(--border);
      border-radius: 14px;
      padding: 20px;
      box-shadow: 0 12px 30px rgba(23, 32, 42, 0.07);
    }
    h1 { margin-top: 0; margin-bottom: 8px; }
    p { color: var(--muted); }
    ul { list-style: none; padding: 0; margin: 0; }
    li + li { margin-top: 12px; }
    a {
      display: block;
      text-decoration: none;
      border: 1px solid var(--border);
      background: #fbfcfe;
      border-radius: 10px;
      padding: 12px 14px;
      color: var(--accent);
      font-weight: 600;
    }
    a:hover { color: #ffffff; background: var(--accent-hover); border-color: var(--accent-hover); }
    .hint { font-size: 14px; margin-top: 18px; }
  </style>
</head>
<body>
<main>
  <section class="card">
    <h1>Plotly Visualizations</h1>
    <p>Select a visualization:</p>
    <ul>
HTML

shopt -s nullglob
count=0
for source_file in "$SRC_DIR"/*.html; do
  file_name="$(basename "$source_file")"
  cp "$source_file" "$OUT_DIR/$file_name"
  printf '      <li><a href="%s">%s</a></li>\n' "$file_name" "$file_name" >> "$INDEX_FILE"
  count=$((count + 1))
done
shopt -u nullglob

if [[ "$count" -eq 0 ]]; then
  cat >> "$INDEX_FILE" <<'HTML'
      <li>No HTML files found in <code>visualizations/</code>.</li>
HTML
fi

cat >> "$INDEX_FILE" <<'HTML'
    </ul>
    <p class="hint">Add exported Plotly HTML files to <code>visualizations/</code> and push to <code>main</code>.</p>
  </section>
</main>
</body>
</html>
HTML

touch "$OUT_DIR/.nojekyll"
echo "Built site at: $OUT_DIR"
