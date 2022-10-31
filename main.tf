terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token-..." CLI option
variable "do_token" {}

#Configure the Digital cean Provider
provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "ssh_key" {
  name = "spirit-digital-ocean"
}

data "digitalocean_project" "lab_project" {
  name = "ACIT 4640"
}

# Create a new tag
resource "digitalocean_tag" "lab_tag" {
  name = "Lab"
}

# Create a new vpc
resource "digitalocean_vpc" "lab_vpc" {
  name   = "ACIT4640"
  region = "sfo3"
}

# Create a new droplet
resource "digitalocean_droplet" "lab_droplet" {
  image    = "rockylinux-9-x64"
  name     = "lab-1"
  tags     = [digitalocean_tag.lab_tag.id]
  region   = "sfo3"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
  vpc_uuid = digitalocean_vpc.lab_vpc.id
}

# Attach the droplet to the project
resource "digitalocean_project_resources" "lab_project_resources" {
  project = data.digitalocean_project.lab_project.id
  resources = [
    digitalocean_droplet.lab_droplet.urn
  ]
}

# Print IP address of new droplet
output "ip_address" {
  value = digitalocean_droplet.lab_droplet.ipv4_address
}