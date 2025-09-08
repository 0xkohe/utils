#!/usr/bin/env bash
# Convert all HEIC files under a folder into PNG using ImageMagick (magick)
# Usage:
#   ./heic2png.sh INPUT_DIR OUTPUT_DIR
#   ./heic2png.sh --inplace INPUT_DIR    # same folder

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 [--inplace] INPUT_DIR [OUTPUT_DIR]"
  exit 1
fi

INPLACE=0
if [[ "$1" == "--inplace" ]]; then
  INPLACE=1
  shift
fi

INPUT_DIR="$(realpath "$1")"
if (( INPLACE )); then
  OUTPUT_DIR="$INPUT_DIR"
else
  OUTPUT_DIR="$(realpath "$2")"
  mkdir -p "$OUTPUT_DIR"
fi

echo "Converting HEIC → PNG"
echo "Input : $INPUT_DIR"
echo "Output: $OUTPUT_DIR"
echo

# find all heic files (case-insensitive)
find "$INPUT_DIR" -type f \( -iname '*.heic' -o -iname '*.heif' \) | while read -r src; do
  # 相対パスを作成
  rel="${src#"$INPUT_DIR"/}"
  dst_rel="${rel%.*}.png"

  if (( INPLACE )); then
    dst="$INPUT_DIR/$dst_rel"
    mkdir -p "$(dirname "$dst")"
  else
    dst="$OUTPUT_DIR/$dst_rel"
    mkdir -p "$(dirname "$dst")"
  fi

  if [[ -f "$dst" ]]; then
    echo "Skip (exists): $dst"
    continue
  fi

  echo "Convert: $src -> $dst"
  magick "$src" "$dst"
done

echo
echo "Done ✅"


#chmod +x heic2png.sh
#./heic2png.sh /path/to/input /path/to/output

# ./heic2png.sh --inplace /path/to/input
