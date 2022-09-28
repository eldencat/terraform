# editorconfig targets
editorconfig-test:
	@echo "$(YELLOW)Checking if the codebase is compliant with the .editorconfig file...$(NC)"
	@docker run \
		--name=editorconfig \
		--rm \
		--user `id -u`:`id -g` \
		-w "/usr/local/app" \
		-v "$(PWD):/usr/local/app" \
		-t mstruebing/editorconfig-checker

test: editorconfig-test
