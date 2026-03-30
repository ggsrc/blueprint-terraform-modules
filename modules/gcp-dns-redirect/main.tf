resource "google_storage_bucket" "redirect_bucket" {
  project                     = var.project_id
  name                        = var.bucket_name
  location                    = var.bucket_location
  uniform_bucket_level_access = true
}

resource "google_compute_backend_bucket" "redirect_backend" {
  project     = var.project_id
  name        = "${var.bucket_name}-backend"
  bucket_name = google_storage_bucket.redirect_bucket.name
}

resource "google_compute_url_map" "redirect_url_map" {
  project = var.project_id
  name    = "${var.bucket_name}-url-map"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
    host_redirect          = var.redirect_host # set empty "" if no host rewrite
    prefix_redirect        = var.redirect_path
  }
}

resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  project = var.project_id
  name    = "${var.bucket_name}-ssl-cert"
  managed {
    domains = [var.domain_name]
  }
}

resource "google_compute_target_https_proxy" "https_proxy" {
  project          = var.project_id
  name             = "${var.bucket_name}-https-proxy"
  url_map          = google_compute_url_map.redirect_url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.self_link]
}

resource "google_compute_global_address" "static_ip" {
  project = var.project_id
  name    = "${var.bucket_name}-ip"
}

resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  project               = var.project_id
  name                  = "${var.bucket_name}-https-rule"
  target                = google_compute_target_https_proxy.https_proxy.self_link
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  ip_address            = google_compute_global_address.static_ip.address
}

resource "google_dns_record_set" "redirect_dns" {
  project      = var.dns_project_id
  name         = "${var.domain_name}."
  type         = "A"
  ttl          = 300
  managed_zone = var.dns_zone_name

  rrdatas = [
    google_compute_global_address.static_ip.address
  ]
}
