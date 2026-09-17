#!/usr/bin/env bash
set -euo pipefail

PUBLISH_ALIAS=$(cat <<'EOF'
!f() {
	branch=$(git symbolic-ref --quiet --short HEAD) || { echo 'not on a branch, aborting'; return 1; }
	if git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
		echo "origin/$branch already exists, use git push instead"
		return 1
	fi
	git push -u origin "$branch"
}; f
EOF
)

git config --global alias.publish "$PUBLISH_ALIAS"

echo "Installed: git publish (alias.publish in global ~/.gitconfig)"
