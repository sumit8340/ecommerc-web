resource "azurerm_kubernetes_cluster" "aks-web" {
  name                = var.cluster_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.node_pool_name
    node_count = var.node_pool_count
    vm_size    = var.node_pool_vm_size
  }

  identity {
    type = var.identity_type
  }
}
resource "azurerm_container_registry" "registry" {
  name                = "containerRegistry1"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Premium"
}
resource "azurerm_role_assignment" "assignment" {
  principal_id                     = azurerm_kubernetes_cluster.aks-web.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.registry.id
  skip_service_principal_aad_check = true
}