#!/bin/bash
cd "$(dirname "$0")"

git submodule add https://github.com/olOwOlo/hugo-theme-even/ site/themes/hugo-theme-even
cd site/themes/hugo-theme-even
git checkout a039a0fadd3e458db752a2c40b86c0bb23f8f600
cd ../../..
git commit . -m "Prepare theme"

read -p "Enter course code: " course
sed -i s/XXXX/$course/g site/config.toml

sed -i s/YYYY/$(date +"%Y")/g site/config.toml
sed -i s/YYYY/$(date +"%Y")/g README.md

echo TODO: Manually edit README.md

rm init.sh
git commit . -m "Post init.sh"
