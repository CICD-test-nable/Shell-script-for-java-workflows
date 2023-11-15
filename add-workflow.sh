#!/bin/bash

ORG_NAME="CICD-test-nable"
repos=$(gh repo list -l java -q '.[].name' --json name -L 400 $ORG_NAME)

for repo in $repos; do
repo_url=https://github.com/CICD-test-nable/$repo.git
test -d $repo || git clone $repo_url
cd $repo
     mkdir -p .github/workflows
     cp ../workflow.yml .github/workflows/
     git add .
     git commit -m "Add workflow file"
     git push

     cd ..
done
