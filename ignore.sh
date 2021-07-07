#!/bin/bash
if output=$(git diff --quiet $CACHED_COMMIT_REF $COMMIT_REF .) && [ -z "$output" ]; then
  echo "No changes in repository to build/deploy."
  curl -s -o /dev/null -w "Response Status for https://api.netlify.com/api/v1/deploys/$DEPLOY_ID/cancel : %{http_code}" -H "Authorization: Bearer $NETLIFY_CANCEL_TOKEN" -d {}  https://api.netlify.com/api/v1/deploys/$DEPLOY_ID/cancel
  exit 0
else
  echo "There are changes in repository to build/deploy."
  exit 1
fi