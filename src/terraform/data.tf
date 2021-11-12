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

data "oci_core_instance" "web-be-vm1" {
    instance_id = oci_core_instance.web-be-vm1.id
}

data "oci_core_instance" "web-be-vm2" {
    instance_id = oci_core_instance.web-be-vm2.id
}