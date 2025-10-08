data "akamai_group" "my_group_id" {
    group_name  = "Akamai Professional Services-1-1NC95D"
    contract_id = "1-1NC95D"
}





data "akamai_property" "my_property" {
  name    = "jviquezc-terraform-demo"
  version = "2"
}




# from: https://techdocs.akamai.com/terraform/docs/common-identifiers
#data "akamai_groups" "my-groups" {
#}
#output "groups" {
#value = data.akamai_groups.my-groups
#} 


#data "akamai_appsec_aap_selected_hostnames" "my_aap_selected_hostnames" {
#  config_id          = 52638
#  security_policy_id = "jviquezc_KSD"
#}

// Get one
data "akamai_appsec_configuration" "my_configuration" {
    name = "jviquezc_KSD"
}


