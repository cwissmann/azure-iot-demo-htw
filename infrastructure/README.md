# Setup Infrastructure

Install Azure CLI: [Download](https://docs.microsoft.com/de-de/cli/azure/install-azure-cli)

Install Terraform: [Download](https://www.terraform.io/downloads)

Create file "localsettings.tfvars" in the same folder with the following content:
```
resourceGroup = "[RESOURCEGROUPNAME]"
location = "[RESOURCEGROUPREGION]"
resourcePrefix = "[PERSONALPREFIX]"
```

Azure login via Azure CLI. Make sure, the correct subscription is selected ("isDefault": true)
```
az login
az account set --subscription "[SUBSCRIPTIONNAME]"
az account list
```

Then run the following terraform commands for creating the infrastructure automatically:

```
terraform init

terraform plan -var-file="localsettings.tfvars"

terraform apply -var-file="localsettings.tfvars"
```