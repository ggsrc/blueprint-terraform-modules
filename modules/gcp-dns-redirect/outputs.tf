output "bucket_url" {
  value       = google_storage_bucket.redirect_bucket.url
  description = "The URL of the GCS bucket."
}

output "ip_address" {
  description = "IP Address of HTTPS Load Balancer."
  value       = google_compute_global_address.static_ip.address
}
