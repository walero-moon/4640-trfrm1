# This project simply creates some resources on Digital Ocean using Terraform.

## How to run.

### Initial setup:

1. Install Terraform. You can install it here: https://developer.hashicorp.com/terraform/tutorials/downloads

2. Configure your .env file. You can use the .env.example file as a template.

3. Source your .env file. You can do this by running the following command:

```bash
source .env
```

4. Run the following command to initialize Terraform:

```bash
terraform init
```

### Creating resources:

You can create all the resources in the file by running the following command:

```bash
terraform apply
```

### Destroying resources:

You can destroy all the resources in the file by running the following command:

```bash
terraform destroy
```
