locals {
  default_branch = "develop"

  svc = {
    # "sample" = {
    #   description = "Testing"
    # }
  }

  lib = {
    # "test" = {
    #   description = "Testing"
    # }
  }

  required_template_files = {
    "Makefile"   = "required/votive/Makefile.tftpl"
    ".gitignore" = "required/votive/.gitignore.tftpl"
  }

  oncreate_files = {
    "docs/icd.md"               = "oncreate/votive/docs/icd.md.tftpl"
    "docs/sdd.md"               = "oncreate/votive/docs/sdd.md.tftpl"
    "docs/conops.md"            = "oncreate/votive/docs/conops.md.tftpl"
    ".cspell.project-words.txt" = "oncreate/votive/.cspell.project-words.txt.tftpl"
  }

  required_files = {
    ".editorconfig" = {
      content = file("required/votive/.editorconfig")
    },
    ".cspell.config.yaml" = {
      content = file("required/votive/.cspell.config.yaml")
    },
    ".taplo.toml" = {
      content = file("required/votive/.taplo.toml")
    },
    ".cargo/config.toml" = {
      content = file("required/votive/.cargo/config.toml")
    },
    ".cargo-husky/hooks/pre-commit" = {
      content = file("required/votive/.cargo-husky/hooks/pre-commit")
    },
    ".cargo-husky/hooks/pre-push" = {
      content = file("required/votive/.cargo-husky/hooks/pre-push")
    },
    ".cargo-husky/hooks/README.md" = {
      content = file("required/votive/.cargo-husky/hooks/README.md")
    },
    ".github/workflows/rust_ci.yml" = {
      content = file("required/votive/.github/workflows/rust_ci.yml")
    },
    ".github/workflows/sanity_checks.yml" = {
      content = file("required/votive/.github/workflows/sanity_checks.yml")
    },
    "LICENSE" = {
      content = file("required/votive/LICENSE")
    }
  }
}

module "votive_svc" {
  source = "./modules/github-repository/"

  for_each = local.svc

  name        = format("votive-svc-%s", each.key)
  description = "Microservice for the Votive Dictionary Management System"
  visibility  = "public"
  required_files = merge(
    local.required_files,
    { for file, path in local.required_template_files :
      file => {
        content = templatefile(path, {
          type = "svc"
          name = format("votive-svc-%s", each.key)
          port = format("80%02.0f", index(keys(local.svc), each.key))
        }),
        overwrite_on_create = true
      }
  })
  oncreate_files = { for file, path in local.oncreate_files :
    file => {
      content = templatefile(path, {
        name = format("votive-svc-%s", each.key)
      })
      overwrite_on_create = false
    }
  }
  default_branch = "develop"
}

module "votive_lib" {
  source = "./modules/github-repository/"

  for_each = local.lib

  name        = format("votive-lib-%s", each.key)
  description = "Library for the Votive Dictionary Management System"
  visibility  = "public"
  required_files = merge(
    local.required_files,
    { for file, path in local.required_template_files :
      file => {
        content = templatefile(path, {
          type = "lib"
          name = format("votive-lib-%s", each.key)
          port = ""
        })
      }
  })
  oncreate_files = { for file, path in local.oncreate_files :
    file => {
      content = templatefile(path, {
        name = format("votive-lib-%s", each.key)
      })
      overwrite_on_create = false
    }
  }
  default_branch = "develop"
}