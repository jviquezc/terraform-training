resource "akamai_property" "property" {
  name        = "terraform-training-jviquezc4.com"
  product_id  = "prd_Fresca"
  contract_id = "ctr_1-1NC95D"
  group_id    = "grp_19293"

  dynamic "hostnames" {
    for_each = local.app_hostnames
    content {
      cname_from             = hostnames.value       # e.g. www.example.com
      cname_to               = "jviquezc4-terraform.edgekey.net" # your edge hostname
      cert_provisioning_type = "CPS_MANAGED"
    }
  }

  # Usa el mismo schema del builder
  rule_format = "v2023-01-05"
  # <<< usa el JSON generado por el builder >>>
  rules = data.local_file.rules.content
}

resource "akamai_cp_code" "my_cp_code" {
  name        = "Terraform-jviquezc4"
  contract_id = "ctr_1-1NC95D"
  group_id    = "grp_19293"
  product_id  = "prd_Fresca"
}

resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = "prd_Fresca"
  contract_id   = "ctr_1-1NC95D"
  group_id      = "grp_19293"
  edge_hostname = "terraform-training-jviquezc4.com.edgesuite.net"
  ip_behavior   = "IPV4"
  timeouts { default = "1h" }
}

data "akamai_property_rules_builder" "my_default_rule" {
  rules_v2023_01_05 {
    name      = "default"
    is_secure = false
    comments  = "Default behaviors apply to all requests unless overridden."

    behavior {
      origin {
        origin_type           = "CUSTOMER"
        hostname              = var.ab_test == "A" ? "origin-a.example.com" : "origin-b.example.com"
        forward_host_header   = "ORIGIN_HOSTNAME"
        cache_key_hostname    = "REQUEST_HOST_HEADER"
        compress              = true
        enable_true_client_ip = false
        http_port             = 80
      }
    }

    behavior {
      cp_code {
        value {
          id   = tonumber(akamai_cp_code.my_cp_code.id) # asegura tipo numérico
          name = akamai_cp_code.my_cp_code.name
        }
      }
    }
  }
}


data "local_file" "rules" {
  filename = "rules.json"
}

// Change the network value to production for the production network
resource "akamai_property_activation" "my_activation" {
  property_id                    = akamai_property.property.id
  network                        = "staging"
  contact                        = ["jviquezc@akamai.com"]
  note                           = "Sample activation"
  version                        = "1"
  auto_acknowledge_rule_warnings = true
  timeouts {
    default = "1h"
  }
}
