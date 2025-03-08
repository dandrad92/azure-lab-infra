terraform {
  backend "azurerm" {
    resource_group_name   = "rg-terraform-backend"
    storage_account_name  = "tfbackendstorage" 
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }
}
