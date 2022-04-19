# Setup Infrastructure

Install Terraform: [Download](https://www.terraform.io/downloads)

Create tfvars file in the same folder with the following content:
```
resourceGroup = "CZ-DI02-IVY-GWC-CW-HTW-DEMO"
location = "Germany West Central"
resourcePrefix = "zdicwhtw"
```
Then run the following commands:

```
terraform init

terraform plan

terraform apply
```