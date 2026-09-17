_seed_commit() {
	echo base >a.txt
	git add a.txt
	git commit -q -m init
}

test_publish_pushes_new_branch() {
	_seed_commit
	assert_success "git publish should push a branch new to origin" git publish
	assert_contains "$(git ls-remote --heads origin)" "refs/heads/master" "origin should now have the branch"
	assert_eq "$(git config --get branch.master.remote)" "origin" "publish should set upstream"
}

test_publish_fails_when_branch_already_on_origin() {
	_seed_commit
	git publish >/dev/null
	assert_failure "git publish should refuse to push an already-published branch" git publish
}

test_publish_does_not_touch_other_branches() {
	_seed_commit
	git checkout -q -b feature
	echo mod >>a.txt
	git commit -q -am feature
	git publish >/dev/null
	assert_contains "$(git ls-remote --heads origin)" "refs/heads/feature" "feature branch should be published"
	assert_eq "$(git ls-remote --heads origin | grep -c refs/heads/master)" "0" "master should not have been pushed"
}

test_publish_fails_on_detached_head() {
	_seed_commit
	git checkout -q --detach HEAD
	assert_failure "git publish should refuse to run on a detached HEAD" git publish
}
