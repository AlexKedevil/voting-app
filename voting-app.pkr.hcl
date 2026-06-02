packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "docker" "voting_app" {
  image  = "ubuntu:22.04"
  commit = true
  changes = [
    "WORKDIR /app",
    "CMD [\"python3\", \"app.py\"]",
    "EXPOSE 5000"
  ]
}

build {
  name = "voting-app-builder"
  sources = [
    "source.docker.voting_app"
  ]

  provisioner "ansible" {
    playbook_file = "./ansible/playbook.yml"
    user          = "root"
  }

  post-processor "docker-tag" {
    repository = "voting-app"
    tags       = ["latest"]
    only       = ["docker.voting_app"]
  }
}
