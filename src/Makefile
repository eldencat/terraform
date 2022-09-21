TF_TAG = 1.3.0-beta1

tf_call = docker run \
	--rm \
	--network host \
	--user `id -u`:`id -g` \
	-v "$(PWD):/usr/local/app/" \
	-w /usr/local/app/ \
	-t hashicorp/terraform:$(TF_TAG) \
	$(1)

.PHONY: fmt plan validate

plan:
	@$(call tf_call,plan)

fmt:
	@$(call tf_call,fmt)

validate:
	@$(call tf_call,validate)

init:
	@$(call tf_call,init)