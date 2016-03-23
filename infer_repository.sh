#!/bin/bash

GithubUser="$1"
GithubProject="$2"
GithubURL="https://github.com/$GithubUser/$GithubProject"
TmpDirectory="./tmp"
ProjectDirectory="$TmpDirectory/$GithubUser/$GithubProject"


git clone "$GithubURL" "$ProjectDirectory"
cd "$ProjectDirectory"
git pull
./gradlew clean
infer -g -a checkers --pmd-xml -- ./gradlew build