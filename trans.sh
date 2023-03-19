#!/usr/bin/env bash

#
# Author: Jake Zimmerman <jake@zimmerman.io>
#
# A simple script to build an HTML file using Pandoc
#

usage() {
  echo "usage: $0 <source.md> <dest.html>"
}

# ----- args and setup -----

src="${1:-}"
dest="${2:-}"
if [ "$src" = "" ] || [ "$dest" = "" ]; then
  2>&1 usage
  exit 1
fi

case "$src" in
  -h|--help)
    usage
    exit
    ;;
esac

# ----- main -----

# -c /users/rain/.pandoc/css/dark.css \
# pandoc_template="pandoc \
#     --katex \
#     --from markdown+tex_math_single_backslash+east_asian_line_breaks \
#     --filter pandoc-sidenote \
#     --to html5+smart \
#     --template=template.html5 \
#     -c /Users/rain/.pandoc/css/theme.css \
#     -c /Users/rain/.pandoc/css/paper.css \
#     -c /users/rain/.pandoc/css/skylighting-gruvbox-theme.css \
#     --toc \
#     --metadata pagetitle=Wiki \
#     --wrap=none"

pandoc_template="pandoc \
    --katex \
    --from markdown+tex_math_single_backslash+east_asian_line_breaks \
    --filter pandoc-sidenote \
    --to html5+smart \
    --template=template1.html \
    -c /Users/rain/.pandoc/css/pandoc.css \
    --toc \
    --metadata pagetitle=Wiki \
    --wrap=none"

dest_dir="$(dirname "$dest")"
mkdir -p "$dest_dir"

# Searches for markdown links (without extension or .md) and appends a .html
# regex1='s/[^!()[]]*(\[[^]]+\])\(([^.)]+)(\.md)?\)/\1(\2.html)/g'
regex1='s/[^!()[]]*(\[[^]]+\])\(([^.)]+)(\.md)?\)/ \1(\2.html)/g'
# [^!\[\])(]*(\[[^\]]+\])\(([^).]+)(\.md)?\)
pandoc_input=$(cat "$src" | sed -r "$regex1")
pandoc_output=$(echo "$pandoc_input" | $pandoc_template)

# POSTPANDOC PROCESSING

# Removes "file" from ![pic of sharks](file:../sharks.jpg)
regex3='s/file://g'

echo "$pandoc_output" | sed -r $regex3 > "$dest"
