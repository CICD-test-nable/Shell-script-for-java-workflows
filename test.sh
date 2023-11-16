#!/bin/bash

ORG_NAME="CICD-test-nable"
#ORG_NAME="n-ablePrivateLimitedColomboSriLanka "

repos=$(gh repo list -q '.[].name' --json name -L 5 $ORG_NAME)

for repo in $repos; do

	repo_url=https://github.com/$ORG_NAME/$repo.git

	test -d $repo || git clone $repo_url

	result=$(./determineprojecttype.sh $repo)

if [[ "$result" == "JAVA" ]]

then
    echo "Java repository found. Adding workflows...."
    cd $repo
     mkdir -p .github/workflows
     cp ../workflow.yml .github/workflows/
     git add .
     git commit -m "Add workflow file"
     git push
     cd ..
else
    echo "This is a non-java repository"
fi

done
