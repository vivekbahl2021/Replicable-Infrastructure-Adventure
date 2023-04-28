# terraform config
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
  backend "azurerm" {
    key = "app.terraform.tfstate"
  }
}


# terraform provider
provider "azurerm" {
  features {}
}
