terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

variable "image_name" {
  type = string
}

variable "image_tag" {
  type = string
}

resource "docker_image" "app_image" {
  name = "${var.image_name}:${var.image_tag}"
}

resource "docker_container" "app_container" {
  name  = "gba6270-final-app"
  image = docker_image.app_image.name

  ports {
    internal = 5000
    external = 5000
  }

  restart = "always"
}
