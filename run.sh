#!/bin/bash
MAX_DAYS=360
MAX_COMMITS_PER_DAY=10

rm -rf .git
git init
cat <<EOF > README.md
# Time Traveler

Want to improve your GitHub vanity metrics ?
Run \`run.sh\`
It will create multiple commits for every day for the last $MAX_DAYS days.

## Commits for the last $MAX_DAYS

EOF
git add .
git commit -m "Initial commit"

days=$(seq $MAX_DAYS | tac)

for day in $days ; do
    commits=$((RANDOM % MAX_COMMITS_PER_DAY + 1))
    for ((i = 1; i <= commits; i++)); do
        date="$day days ago"
        message="Fake committed $date (commit $i)"
        echo "- Added fake commit $message" >> README.md
        git add .
        git commit --date "$date" -m "$message"
    done
done

git log --oneline | tac

cat <<EOF

# Now push to GitHub with something like...

git remote add origin https://github.com/jmfayard/timetraveler.git
git branch -M main
git push -u origin main
EOF
