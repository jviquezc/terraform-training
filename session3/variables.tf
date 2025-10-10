variable "edgerc" {
  type        = string
  description = "Path to the .edgerc file used for Akamai API authentication."
  default     = "~/.edgerc"
}

variable "config_section" {
  type        = string
  description = "Section within the .edgerc file that contains the Akamai API credentials."
  default     = "Terraform"
}

variable "group_id" {
  type        = string
  description = "this is the group id for the terraform training"
  default     = "19293"
}


variable "akamai_client_secret" {
  type        = string
  description = "Client secret for Akamai API (set via environment variable TF_VAR_akamai_client_secret)"
  default     = "mQiZFI8KYWExlISq190vZU+fvrTz94AJR/W/vFfkWdw="
}

variable "akamai_host" {
  type        = string
  description = "Akamai host (e.g. xyz.luna.akamaiapis.net), set via TF_VAR_akamai_host"
  default     = "akab-xbrctnjdqgyuqndr-c5cgpr6zthnz6env.luna.akamaiapis.net"
}

variable "akamai_access_token" {
  type        = string
  description = "Access token for Akamai API, set via TF_VAR_akamai_access_token"
  default     = "akab-bgfxpnszshmehy72-cul4gsdmn5kj7jhs"
}

variable "akamai_client_token" {
  type        = string
  description = "Client token for Akamai API, set via TF_VAR_akamai_client_token"
  default     = "akab-wnv7y6fvunpwek5g-jyfkttmdam6nnjl7"
}

variable "akamai_account_key" {
  type        = string
  description = "Account key for Akamai API, set via TF_VAR_akamai_account_key"
  default     = "1-6JHGX:1-8BYUX"
}


