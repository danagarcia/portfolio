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
    - `git clone https://github.com/danagarcia/portfolio.git`
2. Navigate to `portfolio/src/terraform`
3. Create provider.tf
    - Follow guide: [Set Up OCI Terraform](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm)
4. Initialize Terraform
    - Run `terraform init`
5. Create Plan
    - Run `terraform plan`
6. Apply Plan
    - Run `terraform apply`

# Setps (OCI Resource Manager Stack)
1. Clone this repository to your machine in a directory of your choice
    - `git clone https://github.com/danagarcia/portfolio.git`
2. Navigate to `portfolio/src/terraform`
3. Copy your RSA public key `~/.ssh/id_rsa.pub` to `portfolio/src/terraform`
4. Copy `portfolio/scripts/setup.sh` to `portfolio/src/terraform`
5. Edit `hostname`, `setup_path`, and `ssh_public_key_path` in `variables.tf`
    - `hostname` is your domain name
    - `setup_path` is `./setup.sh`
    - `ssh_public_key_path` is `./id_rsa.pub`
6. Save changes to `variables.tf`
7. Compress all files in `portfolio/src/terraform` into a ZIP archive
8. In the Oracle Cloud Infrastructure portal type `Stacks` in the search
9. Click `Stacks` under the `Services` section of the drop down.
10. Click `Create Stack`
11. Select the `.Zip file` radio in the `Stack Configuration` section
12. Drag and drop the ZIP archive you created into the `Stack Configuration` section
13. Click `Next`
14. Click `Next`
15. Click `Create`
16. The stack will be created and you now can click `Plan` (follow defaults) then `Apply` (follow defaults) to deploy the resources