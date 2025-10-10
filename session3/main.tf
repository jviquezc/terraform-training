locals {
  service_name = "Terraform"
  notes = join(" - ", ["TF-3001", var.group_id])
}

output "notes" {
  value = local.notes
}