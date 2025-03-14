provider "google" {
  region = "us-west1"
}

module "dns_redirect" {
  source          = "../../../gcp-dns-redirect/"
  project_id      = "my-gcp-project"
  bucket_name     = "old-domain-to-new-domain-redirect-bucket"
  bucket_location = "us-west1"
  domain_name     = "old-domain.com"
  redirect_host   = "new-domain.com"
  redirect_path   = "/new-path"
  dns_project_id  = "my-gcp-project"
  dns_zone_name   = "old-domain-zone"
}
