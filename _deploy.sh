#!/usr/bin/env bash
set -eu

echo "Preparing bundle..."
rm -f _site.zip
cd _site
zip -q -r ../_site.zip *
cd ..

echo "Uploading bundle..."
curl -s -H "Content-Type: application/zip" \
     -H "Authorization: Bearer ${ACCESS_TOKEN}" \
     --data-binary "@_site.zip" \
     https://api.netlify.com/api/v1/sites/68881854-ade2-474c-8a8c-447919bdb392/deploys \
     > /dev/null

echo "Done"
