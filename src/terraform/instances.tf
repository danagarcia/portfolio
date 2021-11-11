variable "tenancy_ocid" {
}

variable "compartment_ocid" {
}

variable "region" {
}

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

variable "setup_path" {
    # making an assumption here that terraform is being executed locally and within the terraform directory
    default = "../scripts/setup.sh"
}

variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}

data "oci_identity_availability_domain" "ad1" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_identity_availability_domain" "ad2" {
  compartment_id = var.tenancy_ocid
  ad_number      = 2
}

data "oci_core_subnet" "publicsnad1" {
    subnet_id = oci_core_subnet.publicsnad1.id
}

data "oci_core_subnet" "publicsnad2" {
    subnet_id = oci_core_subnet.publicsnad2.id
}

data "template_file" "setup" {
    template = "${file("${var.setup_path}")}"
}

resource "oci_core_instance" "web-be-vm1" {
  availability_domain = data.oci_identity_availability_domain.ad1.name
  compartment_id      = var.compartment_ocid
  display_name        = "web-be-vm1"
  shape               = var.instance_shape

  metadata = {
    user_data = base64encode(data.template_file.setup.rendered)
  }

  create_vnic_details {
    subnet_id      = data.oci_core_subnet.publicsnad1.id
    hostname_label = "web-be-vm1"
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region]
  }
}

resource "oci_core_instance" "web-be-vm2" {
  availability_domain = data.oci_identity_availability_domain.ad2.name
  compartment_id      = var.compartment_ocid
  display_name        = "web-be-vm2"
  shape               = var.instance_shape

  metadata = {
    user_data = base64encode(data.template_file.setup.rendered)
  }

  create_vnic_details {
    subnet_id      = data.oci_core_subnet.publicsnad2.id
    hostname_label = "web-be-vm2"
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region]
  }
}