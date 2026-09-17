test_install_sets_alias() {
	local publish
	publish=$(git config --global --get alias.publish)
	assert_contains "$publish" "git push -u origin" "alias.publish should be set"
}

test_install_idempotent() {
	assert_success "reinstall should succeed" bash "$ROOT_DIR/install.sh"
	local count
	count=$(git config --global --get-all alias.publish | grep -c '^!f() {$')
	assert_eq "$count" "1" "alias.publish should have a single definition after reinstall, not appended"
}

test_install_does_not_touch_user_config() {
	git config --global user.name "Someone Else"
	git config --global user.email "someone@example.com"
	bash "$ROOT_DIR/install.sh" >/dev/null
	assert_eq "$(git config --global user.name)" "Someone Else" "install should not touch user.name"
	assert_eq "$(git config --global user.email)" "someone@example.com" "install should not touch user.email"
}
