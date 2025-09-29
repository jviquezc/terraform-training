data "akamai_group" "my_group_id" {
    group_name  = "Akamai Professional Services-1-1NC95D"
    contract_id = "1-1NC95D"
}

output "my_group_id" {
    value = data.akamai_group.my_group_id
}



data "akamai_property" "my_property" {
  name    = "jviquezc-terraform-demo"
  version = "2"
}

output "my_property" {
  value = data.akamai_property.my_property
}


#data "akamai_appsec_aap_selected_hostnames" "my_aap_selected_hostnames" {
#  config_id          = 52638
#  security_policy_id = "jviquezc_KSD"
#}

// Get one
data "akamai_appsec_configuration" "my_configuration" {
    name = "jviquezc_KSD"
}

output "my_appsec_config" {
  value = data.akamai_appsec_configuration.my_configuration
}
