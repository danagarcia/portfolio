# Global Variables #
variable "compartment_ocid" {
}
variable "tenancy_ocid" {
}
variable "region" {
}

# Load Balancer Variables #
variable "hostname" {
  default = "danagarcia.com"
}

# Instance Variables #
variable "instance_image_ocid" {
  type = map(string)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.9-2021.10.20-0"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaa5yw4ukpgtmo2gaqhk5phkgenz26y4auuodt7pd6byie5ho6zx5kq"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaanq3ltdsl5ij3cuvqimjwt5yctb7eolglzvkbq2u6wypanj5aazga"
    us-sanjose-1 = "ocid1.image.oc1.us-sanjose-1.aaaaaaaacm32nukryvrugwg2aeupbl342mx7oaa6gz4fwfd7uucm7u36alcq"
  }
}
variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}
variable "setup_path" {
    # making an assumption here that terraform is being executed locally and within the terraform directory
    default = "../scripts/setup.sh"
}
variable "ssh_public_key_path" {
  default = "./.ssh/id_rsa.pub"
}