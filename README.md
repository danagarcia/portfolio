# Summary
Utilize Terraform, Bash and NodeJS to create a fully automated deployment of a portfolio website into OCI.

# Description
NodeJS portfolio site (didn't design this myself, just editted 'i am john' portfolio) that is deployed to Oracle Cloud Infrastructure (OCI) via Terraform with a Bash bootstrap for configuration of instances. The porfolio is made highly available if the OCI region supports multiple availability domains, otherwise it will deploy two instances on a single availability domain. The configuration looks like this:
![Diagram](/img/Diagram1.png?raw=true "Diagram")

# Usage
## Prerequisites
- Terraform: [Installation Instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- Oracle Cloud Infrastruction Tenancy: [Try Free](https://www.oracle.com/cloud/)

## Steps (Local CLI)
1. Clone this repository to your machine in a directory of your choice
  1. `git clone https://github.com/danagarcia/portfolio.git`
1. Navigate to `portfolio/src/terraform`
1. Create provider.tf
  1. Follow guide: [Set Up OCI Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)
1. Initialize Terraform
  1. Run `terraform init`
1. Create Plan
  1. Run `terraform plan`
1. Apply Plan
  1. Run `terraform apply`

# Setps (OCI Resource Manager Stack)
1. Clone this repository to your machine in a directory of your choice
  1. `git clone https://github.com/danagarcia/portfolio.git`
1. Navigate to `portfolio/src/terraform`
1. Copy your RSA public key `~/.ssh/id_rsa.pub` to `portfolio/src/terraform`
1. Copy `portfolio/scripts/setup.sh` to `portfolio/src/terraform`
1. Edit `hostname`, `setup_path`, and `ssh_public_key_path` in `variables.tf`
  1. `hostname` is your domain name
  1. `setup_path` is `./setup.sh`
  1. `ssh_public_key_path` is `./id_rsa.pub`
1. Save changes to `variables.tf`
1. Compress all files in `portfolio/src/terraform` into a ZIP archive
1. In the Oracle Cloud Infrastructure portal type `Stacks` in the search
1. Click `Stacks` under the `Services` section of the drop down.
1. Click `Create Stack`
1. Select the `.Zip file` radio in the `Stack Configuration` section
1. Drag and drop the ZIP archive you created into the `Stack Configuration` section
1. Click `Next`
1. Click `Next`
1. Click `Create`
1. The stack will be created and you now can click `Plan` (follow defaults) then `Apply` (follow defaults) to deploy the resources