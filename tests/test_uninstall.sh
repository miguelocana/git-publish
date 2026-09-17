test_uninstall_removes_alias() {
	git config --global --unset alias.publish
	assert_failure "git publish should no longer exist" git config --global --get alias.publish
}
