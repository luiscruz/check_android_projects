#!/bin/bash

GitUser="$1"
GitProject="$2"
GitURL="https://github.com/$GitUser/$GitProject"
TmpDirectory="./tmp"
ProjectDirectory="$TmpDirectory/$GitUser/$GitProject"

git clone "$GitURL" "$ProjectDirectory"
cd "$ProjectDirectory"
git pull
./gradlew clean
infer -g -a checkers --pmd-xml -- ./gradlew build