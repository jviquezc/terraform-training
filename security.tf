resource "akamai_appsec_configuration" "create_config" {
 name        = "terraform-training-jviquezc2.com"
 description = "This is my new configuration."
 contract_id = "1-1NC95D"
 group_id    = 19293
 host_names  = ["terraform-training-jviquezc2.com"]
 }




// Create new security policy using the config_id from the data source
resource "akamai_appsec_security_policy" "terraformsecpolicy2" {
  config_id              = akamai_appsec_configuration.create_config.config_id
  default_settings       = true
  security_policy_name   = "terraform-training-jviquezc2.com"
  security_policy_prefix = "jv93"
}