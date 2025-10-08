resource "akamai_property" "property" {
  name        = "terraform-training-jviquezc2.com"
  product_id  = "prd_Fresca"
  contract_id = "ctr_1-1NC95D"
  group_id    = "grp_19293"

  hostnames {
    cname_from             = "terraform-training-jviquezc2.com"
    cname_to               = akamai_edge_hostname.my_edge_hostname.edge_hostname
    cert_provisioning_type = "CPS_MANAGED"
  }

  # Usa el mismo schema del builder
  rule_format = "v2023-01-05"
  # <<< usa el JSON generado por el builder >>>
  rules       = data.local_file.rules.content
}

resource "akamai_cp_code" "my_cp_code" {
  name        = "Terraform-jviquezc"
  contract_id = "ctr_1-1NC95D"
  group_id    = "grp_19293"
  product_id  = "prd_Fresca"
}

resource "akamai_edge_hostname" "my_edge_hostname" {
  product_id    = "prd_Fresca"
  contract_id   = "ctr_1-1NC95D"
  group_id      = "grp_19293"
  edge_hostname = "terraform-training-jviquezc2.com.edgesuite.net"
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
        origin_type         = "CUSTOMER"
        hostname            = "origin-terraform-training-jviquezc2.com"
        forward_host_header = "ORIGIN_HOSTNAME"
        cache_key_hostname  = "REQUEST_HOST_HEADER"
        compress            = true
        enable_true_client_ip = false
        http_port           = 80
      }
    }

    behavior {
      cp_code {
        value {
          id   = tonumber(akamai_cp_code.my_cp_code.id)  # asegura tipo numérico
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
