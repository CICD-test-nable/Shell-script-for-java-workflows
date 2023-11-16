#!/bin/bash

ORG_NAME="CICD-test-nable"
branch_name="spims"

repos=$(gh repo list -q '.[].name' --json name -L 400 $ORG_NAME)

for repo in $repos; do

	repo_url=https://github.com/$ORG_NAME/$repo.git

	test -d $repo || git clone $repo_url

	result=$(./determineprojecttype.sh $repo)

if [[ "$result" == "JAVA" ]]

then

if git show-ref --quiet refs/remotes/origin/"$branch_name"; then
    echo "Branch $branch_name found"
else                                                            
    echo "...................Creating $branch_name ....................."
    git branch $branch_name
fi                                                                               

    cd $repo
     echo ".....................Switching to $branch_name ....................."
     git checkout $branch_name
     mkdir -p .github/workflows
     cp ../workflow.yml .github/workflows/
     git add .
     git commit -m "Add workflow file"
     git push -u origin $branch_name
     cd ..

else
    echo "This is a non-java repository"
fi

done
