terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup2"
  location = "uksouth"
}

resource "azurerm_resource_group" "rg2" {
	name = "myTFResourceGroup3"
	location = "uksouth"
}

module "myresource_tagging" {
  source  = "../terraform-azurerm-tagging"

  nb_resources = 2
  resource_ids = [azurerm_resource_group.rg.id, azurerm_resource_group.rg2.id]
  behavior     = "merge"   # Must be "merge" or "overwrite"

  tags = {
    "foo"        = "bar"
    "monitoring" = "true"
  }
}

