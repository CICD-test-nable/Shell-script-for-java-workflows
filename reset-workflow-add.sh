#!/bin/bash

ORG_NAME="CICD-test-nable"
branch="spims"
repos=$(gh repo list -l java -q '.[].name' --json name -L 400 $ORG_NAME)

for repo in $repos; do
	repo_url=https://github.com/$ORG_NAME/$repo.git
	test -d $repo || git clone $repo_url
	git -C $repo checkout $branch
	git -C $repo reset --hard origin/no-workflow
	git -C $repo push -f
done
