terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.40.0"
    }
    github = {
      source = "integrations/github"
      version = "5.9.1"
    }    
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "github" {
  token = var.git-token
}

resource "github_repository" "myrepo" {
  name = "book-repo"
  auto_init = true
  visibility = "private"
}

resource "github_branch_default" "main" {
  branch = "main"  
  repository = github_repository.myrepo.name
}

resource "github_repository_file" "myfiles" {
  for_each = toset(var.files)
  content = file(each.value)
  file = each.value
  repository = github_repository.myrepo.name
  branch = "main"
  commit_message = "managed by terraform"
  overwrite_on_create = true
}