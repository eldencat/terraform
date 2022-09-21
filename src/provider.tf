terraform {
  cloud {
    organization = "eldencat"
    workspaces {
      name = "terraform"
    }
  }
}

provider "github" {
  owner        = "eldencat"
  organization = "eldencat"
  #   app_auth {}
}
