provider "github" {
  owner = "eldencat"
  app_auth {
    token = var.github_token
  }
}
