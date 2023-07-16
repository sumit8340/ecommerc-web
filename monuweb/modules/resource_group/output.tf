output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.ecommerce-rg.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.ecommerce-rg.location
}