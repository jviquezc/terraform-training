resource "akamai_gtm_property" "demo_property" {
    domain = "jviquezc5.akadns.net"
    name = "terraform-demo"
    type =  "weighted-round-robin"
    score_aggregation_type = "median"
    handout_limit = 5
    handout_mode = "normal"
    traffic_target {
        datacenter_id = 3131
    }
}