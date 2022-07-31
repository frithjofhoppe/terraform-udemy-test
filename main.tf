terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.12.1"
    }
  }
}

provider "kubernetes" {
}

resource "kubernetes_manifest" "udemy-sa" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "name"      = "udemy-sa-5"
      "namespace" = "default"
    }
  }
}

data "kubernetes_resource" "udemy-sa" {
  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name = kubernetes_manifest.udemy-sa.object.metadata.name
  }
}

data "kubernetes_resource" "udemy-sa-secret" {
  api_version = "v1"
  kind        = "Secret"
  metadata {
    name = data.kubernetes_resource.udemy-sa.object.secrets[0].name
  }
}
