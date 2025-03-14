# GCP DNS Redirect Module

A Terraform module for Google Cloud Platform that creates an HTTPS load balancer to perform domain redirects with proper SSL certificates and DNS configuration.

## Description

This module sets up infrastructure in Google Cloud Platform to redirect a domain to another URL. It creates:

- A Google Cloud Storage bucket
- A global HTTPS load balancer with SSL certificate
- DNS A record configuration
- URL redirection rules

Ideal for domain forwarding, branded links, or migration scenarios where you need to redirect traffic from one domain to another destination.

## Requirements

- Google Cloud Platform project with appropriate APIs enabled:
  - Compute Engine API
  - Cloud Storage API
  - Cloud DNS API
- DNS zone already configured in GCP Cloud DNS
- Terraform >= 0.13.x
- Google provider >= 3.0.0

## Input Variables

| Name              | Description                                          | Type     | Required |
| ----------------- | ---------------------------------------------------- | -------- | -------- |
| `project_id`      | The ID of the GCP project                            | `string` | Yes      |
| `bucket_name`     | The name of the GCS bucket (must be globally unique) | `string` | Yes      |
| `bucket_location` | The location of the GCS bucket                       | `string` | Yes      |
| `domain_name`     | Domain name to redirect                              | `string` | Yes      |
| `redirect_host`   | The host to redirect requests to                     | `string` | Yes      |
| `redirect_path`   | The path to redirect requests to                     | `string` | Yes      |
| `dns_project_id`  | The ID of the GCP project for the DNS zone           | `string` | Yes      |
| `dns_zone_name`   | The name of the DNS zone                             | `string` | Yes      |

## Outputs

| Name         | Description                       |
| ------------ | --------------------------------- |
| `bucket_url` | The URL of the GCS bucket         |
| `ip_address` | IP Address of HTTPS Load Balancer |

## Example

See the [examples/basic-redirect](./examples/basic-redirect) directory for a complete working example.
