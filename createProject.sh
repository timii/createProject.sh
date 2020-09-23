#!/bin/bash

# script to create a new folder and a new repository for it on github with an initial commit and README

# replace PATH with your own path the script is saved to (preferably "~" or somewhere easy to find)
# usage: . PATH/createProject.sh repo_name repo_desc
# repo_name: name of the project folder and repository
# repo_desc: description for the created github repository

num_args=$#
echo $num_args

# if no or only one argument is given stop the script and show error message
if [ $num_args == 0 ] || [ $num_args == 1 ]
    then
        echo "Arguments missing"
        echo "correct usage: . PATH/createProject.sh repo_name repo_desc"
        return
fi

# set arguments as variables
repo_name=$1
repo_desc=${*:2}

# generate your personal access token on github with atleast "repo" as a scope and replace it with YOUR_PERSONAL_TOKEN
access_token='YOUR_PERSONAL_TOKEN'

# changes the current directory to your projects directory
# replace PATH with the path to your projects folder
cd PATH

# create a directory for your new project
mkdir "$repo_name"

# move into the created directory
cd "$repo_name"

# create a README file to be able to push an initial commit to github and add a temporary README
touch README.md
echo '# '"$repo_name"'' >> README.md

# initialize a git repository
git init

# create a remote repository on github with the same name as the new directory
# Source: https://developer.github.com/changes/2020-02-10-deprecating-auth-through-query-param/
curl -H 'Authorization: token '"$access_token"'' https://api.github.com/user/repos -d '{"name":'"\"$repo_name\""',"description":'"\"$repo_desc\""',"private":"true"}'

# add the remote
# replace YOUR_GITHUB_USERNAME with your github username
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/"$repo_name".git

# stage your changes
git add .

# commit your changes
git commit -m "initial commit"

# push the initial commit to the remote repository
git push origin master

