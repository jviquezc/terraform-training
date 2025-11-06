resource "akamai_gtm_property" "demo_property" {
  domain = "jviquezc6.akadns.net"
  name   = "terraform-demo"
  type   = "weighted-round-robin"

  score_aggregation_type = "median"
  handout_limit          = 5
  handout_mode           = "normal"

  traffic_target {
    datacenter_id = akamai_gtm_datacenter.origin_dc.datacenter_id
    enabled       = true
    weight        = 1

    servers = [
      "akamaiflowershop.com"
    ]
  }
}


resource "akamai_gtm_datacenter" "origin_dc" {
  domain   = "jviquezc6.akadns.net"
  nickname = "origin-dc"

  city              = "San Jose"
  state_or_province = "SJ"
  country           = "CR"
  continent         = "SA"
}

resource "akamai_gtm_domain" "my-domain" {
  contract                = "ctr_1-1NC95D"
  group                   = 19293
  name                    = "jviquezc6.akadns.net"
  type                    = "basic"
  email_notification_list = ["jviquezc@akamai.com"]
  comment                 = "Sample comment"
}


