# phpIPAM-Azure-AppService
 phpIPAM docker running in Azure App Service




Terraform:
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars" -auto-approve
terraform destroy