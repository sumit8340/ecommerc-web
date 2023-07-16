resource "azurerm_mssql_server" "mysql" {
  name                         = var.mssql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}
resource "azurerm_mssql_database" "ecommerce_db" {
  name                = var.database_name
  server_id           = azurerm_mssql_server.mysql.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 5
  create_mode         = "Default"
}
