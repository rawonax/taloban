#!/bin/bash

REPO_NAME="taloban"
GIT_USER_NAME="rawonax"
GIT_USER_EMAIL="rawonax7@gmail.com"
REMOTE_URL="https://github.com/rawonax/taloban.git" # ← GitHub 저장소 주소로 바꿔야 함

mkdir -p $REPO_NAME
cd $REPO_NAME
git init
git config user.name "$GIT_USER_NAME"
git config user.email "$GIT_USER_EMAIL"
touch log.txt

start_date="2024-03-01"
end_date=$(date +%Y-%m-%d)
current_date="$start_date"

while [ "$current_date" != "$(date -j -v+1d -f "%Y-%m-%d" "$end_date" +"%Y-%m-%d")" ]; do
  commit_count=$((RANDOM % 6))
  for ((i = 0; i < commit_count; i++)); do
    random_hour=$((RANDOM % 24))
    random_minute=$((RANDOM % 60))
    random_second=$((RANDOM % 60))
    commit_time=$(printf "%02d:%02d:%02d" $random_hour $random_minute $random_second)
    full_datetime="$current_date $commit_time"

    echo "$full_datetime" >> log.txt
    git add log.txt
    GIT_AUTHOR_DATE="$full_datetime" GIT_COMMITTER_DATE="$full_datetime" \
    git commit -m "Commit on $full_datetime"
  done

  current_date=$(date -j -v+1d -f "%Y-%m-%d" "$current_date" +"%Y-%m-%d")
done

git branch -M main
git remote add origin "$REMOTE_URL"
git push -u origin main
