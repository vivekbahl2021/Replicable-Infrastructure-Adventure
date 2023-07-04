resource "azurerm_resource_group" "rg" {

   name     = "rg-test-adevnture-eastus-01"

  location = "eastus"

   tags = {

     Environment             = "test"

     Deployed_with_Terraform = "true"

   }

}

