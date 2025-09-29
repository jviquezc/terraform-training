terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc         = var.edgerc_path
  config_section = var.config_section
}

resource "akamai_gtm_domain" "jviquezc-tf" {
  contract                  = var.contractid
  group                     = var.groupid
  name                      = "jviquezc-tf.akadns.net"
  type                      = "basic"
  comment                   = "Delete property fo2"
  default_timeout_penalty   = 25
  load_imbalance_percentage = 10
  default_error_penalty     = 75
  cname_coalescing_enabled  = false
  load_feedback             = false
  end_user_mapping_enabled  = false
}
