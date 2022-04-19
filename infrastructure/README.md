# Setup Infrastructure

Install Terraform: [Download](https://www.terraform.io/downloads)

Create file "localsettings.tfvars" in the same folder with the following content:
```
resourceGroup = "[RESOURCEGROUPNAME]"
location = "[RESOURCEGROUPREGION]"
resourcePrefix = "[PERSONALPREFIX]"
```
Then run the following commands:

```
terraform init

terraform plan -var-file="localsettings.tfvars"

terraform apply
```