resource "azurerm_resource_group" "rg" {
  name     = "rg-test-adevnture-eastus-01"
  location = "east-us"
  tags = {
    Environment             = "test"
    Deployed_with_Terraform = "true"
  }
}

