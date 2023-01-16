# Terraform
Terraform scripts

Install terraform
https://developer.hashicorp.com/terraform/downloads

extract files and copy location of terraform.exe
open environment variables and paste in path

# Terraform Commands
To Initialize
```bash
$ terraform init
```


To execute dry run
```bash
$ terraform plan
```


Execute code
```bash
$ terraform apply
```


Skip the approval
```bash
$ terraform apply -auto-approve
```


To destroy everything that is created
```bash
$ terraform destroy -auto-approve
```


Shows the info about the resources we deployed
```bash
$ terraform show
```


It will show the plan to destroy
```bash
$ terraform plan -destroy
```

you'll get help on the plan command
```bash
$ terraform -h plan
```

format your code
```bash
$ terraform fmt
```