TF_VARS := ./empire.tfvars

.PHONY: apply destroy plan

apply:
	@terraform apply -var-file=$(TF_VARS)

destroy:
	@terraform destroy -var-file=$(TF_VARS)

plan:
	@terraform plan -var-file=$(TF_VARS)
