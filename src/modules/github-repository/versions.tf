terraform {
  required_version = ">= 1.3"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.3.0"
    }
  }

  cloud {
    organization = "eldencat"
    workspaces {
      name = "terraform"
    }
  }
}