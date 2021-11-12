resource "oci_load_balancer" "publiclb" {
    shape = "flexible"
    shape_details {
        maximum_bandwidth_in_mbps = 10
        minimum_bandwidth_in_mbps = 10
    }
    compartment_id = var.compartment_id

    subnet_ids = [
        data.oci_core_subnet.publicsnad1.id,
        data.oci_core_subnet.publicsnad2.id,
    ]

    display_name = "publiclb"
}

resource "oci_load_balancer_backend_set" "publiclb-bes" {
    name = "publiclb-bes"
    load_balancer_id = oci_load_balancer.publiclb.id
    policy = "ROUND_ROBIN"

    health_checker {
        port = "80"
        protocol = "HTTP"
        response_body_regex = ".*"
        url_path = "/"
    }
}

resource "oci_load_balancer_path_route_set" "publiclb-prs" {
    load_balancer_id = oci_load_balancer.publiclb.id
    name = "publiclb-prs"

    path_routes {
        backend_set_name = oci_load_balancer_backend_set.publiclb-bes.id
        path = "/"

        path_match_type {
            match_type = "EXACT_MATCH"
        }
    }
}

resource "oci_load_balancer_hostname" "publiclb-hn" {
    hostname = "${var.hostname}"
    load_balancer_id = oci_load_balancer.publiclb.id
    name = "publiclb-hn"
}

resource "oci_load_balancer_listener" "http-listener" {
    load_balancer_id = oci_load_balancer.publiclb.id
    name = "http"
    default_backend_set_name = oci_load_balancer_backend_set.publiclb-bes.name
    hostname_names = [oci_load_balancer_hostname.publiclb-hn.name]
    port = 80
    protocol = "HTTP"
    
    connection_configuration {
        idle_timeout_in_seconds = "2"
    }
}

resource "oci_load_balancer_backend" "publiclb-be1" {
    load_balancer_id = oci_load_balancer.publiclb.id
    backendset_name = oci_load_balancer_backend_set.publiclb-bes.name
    ip_address = data.oci_core_instance.web-be-vm1.private_ip
    port = 80
    backup = false
    drain = false
    offline = false
    weight = 1
}

resource "oci_load_balancer_backend" "publiclb-be2" {
    load_balancer_id = oci_load_balancer.publiclb.id
    backendset_name = oci_load_balancer_backend_set.publiclb-bes.name
    ip_address = data.oci_core_instance.web-be-vm2.private_ip
    port = 80
    backup = false
    drain = false
    offline = false
    weight = 1
}