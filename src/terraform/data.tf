data "oci_identity_availability_domains" "ads" {
    compartment_id = var.tenancy_ocid
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