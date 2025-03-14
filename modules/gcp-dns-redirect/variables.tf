
variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket (must be globally unique)."
  type        = string
}

variable "bucket_location" {
  description = "The location of the GCS bucket."
  type        = string
}

variable "domain_name" {
  description = "Domain name to redirect."
  type        = string
}

variable "redirect_host" {
  description = "The host to redirect requests to."
  type        = string
}

variable "redirect_path" {
  description = "The path to redirect requests to."
  type        = string
}

variable "dns_project_id" {
  description = "The ID of the GCP project for the DNS zone."
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the DNS zone."
  type        = string
}
