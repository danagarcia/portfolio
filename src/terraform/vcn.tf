resource "oci_core_vcn" "prodvcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "prodvcn"
  dns_label      = "prodvcn"
}

resource "oci_core_internet_gateway" "prodinternetgateway" {
  compartment_id = var.compartment_ocid
  display_name   = "prodinternetgateway"
  vcn_id         = oci_core_vcn.prodvcn.id
}

resource "oci_core_route_table" "prodroutetable" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.prodvcn.id
  display_name   = "prodroutetable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.prodinternetgateway.id
  }
}

resource "oci_core_security_list" "prodsecuritylist" {
  display_name   = "prodsecuritylist"
  compartment_id = oci_core_vcn.prodvcn.compartment_id
  vcn_id         = oci_core_vcn.prodvcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }
}

resource "oci_core_subnet" "publicsnad1" {
  availability_domain = var.ad1name
  cidr_block          = "10.0.1.0/24"
  display_name        = "publicsnad1"
  dns_label           = "publicsnad1"
  security_list_ids   = [oci_core_security_list.prodsecuritylist.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.prodvcn.id
  route_table_id      = oci_core_route_table.prodroutetable.id
  dhcp_options_id     = oci_core_vcn.prodvcn.default_dhcp_options_id

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "publicsnad2" {
  availability_domain = var.ad2name
  cidr_block          = "10.0.2.0/24"
  display_name        = "publicsnad2"
  dns_label           = "publicsnad2"
  security_list_ids   = [oci_core_security_list.prodsecuritylist.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.prodvcn.id
  route_table_id      = oci_core_route_table.prodroutetable.id
  dhcp_options_id     = oci_core_vcn.prodvcn.default_dhcp_options_id

  provisioner "local-exec" {
    command = "sleep 5"
  }
}