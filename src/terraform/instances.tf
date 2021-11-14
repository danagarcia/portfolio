resource "oci_core_instance" "web-be-vm1" {
  availability_domain = var.ad1name
  compartment_id      = var.compartment_ocid
  display_name        = "web-be-vm1"
  shape               = var.instance_shape

  metadata = {
    user_data = base64encode("${file("${var.script_path}")}")
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
  availability_domain = var.ad2name
  compartment_id      = var.compartment_ocid
  display_name        = "web-be-vm2"
  shape               = var.instance_shape

  metadata = {
    user_data = base64encode("${file("${var.script_path}")}")
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