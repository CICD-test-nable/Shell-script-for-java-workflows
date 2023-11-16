#!/bin/bash

ORG_NAME="CICD-test-nable"

repos=$(gh repo list -q '.[].name' --json name -L 400 $ORG_NAME)

for repo in $repos; do

	repo_url=https://github.com/$ORG_NAME/$repo.git

	test -d $repo || git clone $repo_url

	result=$(./determineprojecttype.sh $repo)

if [[ "$result" == "JAVA" ]]

then
    cd $repo
     echo "crating spims barnch"
     git checkout -b spims
     mkdir -p .github/workflows
     cp ../workflow.yml .github/workflows/
     git add .
     git commit -m "Add workflow file"
     git push -u origin spims
     cd ..
i
else
    echo "This is a non-java repository"
fi

done
