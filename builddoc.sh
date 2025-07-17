#!/bin/bash

pre_readme="./skel.pre"

cat "$pre_readme" > README.md
echo "" >> README.md

readme_files=$(find ./roles -type f -name "README.md")

echo "##Roles" >> README.md
# Roles TOC
for readme_file in $readme_files
do
    role_name=$(dirname "$readme_file" | xargs basename)
    ref=$(echo "$role_name" | tr ' ' '-')
    echo "- [$role_name](#${ref})" >> README.md
done

echo "" >> README.md

for readme_file in $readme_files
do
    role_name=$(dirname "$readme_file" | xargs basename)
    echo "### \`${role_name}\`" >> README.md
    cat "$readme_file" >> README.md
    echo "" >> README.md
done
