#!/bin/sh

TmpDirectory="./tmp"
CurrentTime=$(date "+%Y_%m_%d-%H_%M")
ResultsFilename="results_$CurrentTime.csv"
echo "GithubUser,GithubProject,InferError,Issues,IssuesInternalAccessors" > "$ResultsFilename"
while read Row
do
		GithubUser=$(echo $Row |cut -d',' -f1)
		GithubProject=$(echo $Row |cut -d',' -f2)
		echo "---$GithubProject"
		if [ -n "$GithubUser" ] && [ -n "$GithubProject" ]; then
			ProjectDirectory="$TmpDirectory/$GithubUser/$GithubProject"
			sh infer_repository.sh $GithubUser $GithubProject
			InferError="$?"
			if [ $InferError -eq 0 ]; then
				IssuesCount=$(python count_infer_issues.py $ProjectDirectory/infer-out/report.json)
				InternalAccessorsCount=$(python count_infer_issues.py --bug_type CHECKERS_ANDROID_INTERNAL_ACCESSORS $ProjectDirectory/infer-out/report.json)
			fi
		fi
		echo "$GithubUser,$GithubProject,$InferError,$IssuesCount,$InternalAccessorsCount" >> "$ResultsFilename"
done < android-projects.csv