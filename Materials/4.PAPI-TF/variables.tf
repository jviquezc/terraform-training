variable "edgerc_path" {
  type    = string
  default = "~/.edgerc"
}

variable "config_section" {
  type    = string
  default = "default"
}

variable "contract_id" {
  type    = string
  default = "ctr_1-1NC95D"
}

variable "group_name" {
  type    = string
  default = "JAESCALO Testing"
}

variable "product_id" {
  type    = string
  default = "prd_Fresca"
}

variable "ip_behavior" {
  type    = string
  default = "IPV6_COMPLIANCE"
}

variable "rule_format" {
  type    = string
  default = "v2023-01-05"
}

variable "network" {
  type    = string
  default = "STAGING"
}

variable "emails" {
  type = list(string)
  default = ["jaescalo@akamai.com"]
}

variable "properties" {
  type = map(object({
    property_name = string
    cpcode_name = string
    origin = string
    hostnames = list(string)
  }))
}

variable "version_notes" {
  type = string
  default = "Created and Activated by TF"
}