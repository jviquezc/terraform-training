terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = "= 5.0.0"
    }
  }
  required_version = ">= 0.13"
}

provider "akamai" {
  edgerc         = var.edgerc_path
  config_section = var.config_section
}

data "akamai_group" "group" {
  group_name  = var.group_name
  contract_id = var.contract_id
}

data "akamai_contract" "contract" {
  group_name = data.akamai_group.group.group_name
}

# Because we can't use a complex object (like our hostnames element in the 'properties' variable) directly with 'for_each'. It needs a set or map of strings where each string is a unique identifier for the resource to be created. We have to flatten it to a map of strings.
locals {
  all_properties = flatten([
    for property_key, property in var.properties : [
      for hostname in property.hostnames : {
        hostname = hostname
        cpcode_name = property.cpcode_name
        origin = property.origin
        property_name = property.property_name
      }
    ]])
  properties_map = { for item in local.all_properties : item.hostname => item }
}

output "properties_map" {
  value = local.properties_map
}

resource "akamai_cp_code" "my_cp_code" {

  for_each = var.properties

  name        = each.value.cpcode_name
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_group.group.id
  product_id  = var.product_id
}

data "akamai_property_rules_template" "rules" {
  for_each = var.properties

  template_file = abspath("${path.module}/property-snippets/main.json")
  variables {
    name  = "cpcode"
    value = akamai_cp_code.my_cp_code[each.key].id
    type  = "number"
  }
  variables {
    name  = "origin"
    value = each.value.origin
    type  = "string"
  }
}

resource "akamai_edge_hostname" "my_edge_hostname" {
  for_each = local.properties_map

  product_id  = var.product_id
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_group.group.id
  edge_hostname = format("%s.edgesuite.net", each.key)
  ip_behavior = var.ip_behavior
}

resource "akamai_property" "my_property" {
  for_each = var.properties

  name        = each.value.property_name
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_group.group.id
  product_id  = var.product_id

  dynamic hostnames { 

    for_each = each.value.hostnames

    content {
      cname_from = hostnames.value
      cname_to = "${hostnames.value}.edgesuite.net"
      cert_provisioning_type = "DEFAULT"
    }
  }

  rule_format = var.rule_format
  rules       = replace(data.akamai_property_rules_template.rules[each.key].json, "\"rules\"", "\"comments\": \"${var.version_notes}\", \"rules\"")

  depends_on = [ akamai_edge_hostname.my_edge_hostname ]
}

resource "akamai_property_activation" "my_staging_activation" {

  for_each = var.properties

  property_id                    = akamai_property.my_property[each.key].id
  contact                        = var.emails
  version                        = akamai_property.my_property[each.key].latest_version
  network                        = var.network
  auto_acknowledge_rule_warnings = true
}

# resource "akamai_property_activation" "my_production_activation" {

#   for_each = var.properties

#   property_id                    = akamai_property.my_property[each.key].id
#   contact                        = ["jaescalo@akamai.com"]
#   version                        = akamai_property.my_property[each.key].latest_version
#   network                        = "PRODUCTION"
#   auto_acknowledge_rule_warnings = false
# }
