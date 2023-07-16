module "resource_group" {
  source                  = "../../modules/resource_group"
  resource_group_name = "ecommerce-rg"
  resource_group_location = "east us"
}
module "virtual_network" {
  depends_on = [ module.resource_group ]
  source = "../../modules/networking"
  virtual_network_name = "myvnet"
  resource_group_location           = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  address_space        = "10.0.0.0/16"
  subnets = [
    {
      name   = "default"
      prefix = "10.0.1.0/24"
    }
  ]
}
module "storage_account" {
  depends_on               = [module.resource_group]
  source                   = "../../modules/storage_account"
  storage_account_name     = "storageacweb"
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
module "aks_cluster" {
  depends_on          = [module.resource_group]
  source              = "../../modules/aks"
  cluster_name        = "aks-web"
  resource_group_location           = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = "devopsmonuaks"
  node_pool_name      = "default"
  node_pool_count     = 1
  node_pool_vm_size   = "Standard_D2_v2"
  identity_type       = "SystemAssigned"
}
module "sql_module" {
  depends_on                   = [module.resource_group]
  source                       = "../../modules/database"
  mssql_server_name              = "mysql"
  resource_group_name          = module.resource_group.resource_group_name
  resource_group_location                    = module.resource_group.resource_group_location
  sql_version                  = "12.0"
  administrator_login          = "admin"
  administrator_login_password = "P@ssw01rd@123"
  database_name                = "ecommerce_db"
}
