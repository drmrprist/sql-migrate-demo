# Online Migration to Azure SQL MI via LRS
# Source: Azure VM SQL Server (10.0.1.5)
# Target: Azure SQL Managed Instance (eshop-sqlmi)
# Method: Log Replay Service (LRS) - Online migration

# Step 1: Create storage account and containers
az storage account create --name eshopmibackups --resource-group sql-migrate-rg --location southeastasia --sku Standard_LRS
az storage container create --name catalogdb-backups --account-name eshopmibackups --auth-mode login
az storage container create --name identitydb-backups --account-name eshopmibackups --auth-mode login

# Step 2: Take full backup on source and upload to blob
# BACKUP DATABASE [Microsoft.eShopOnWeb.CatalogDb] TO URL = N'https://eshopmibackups.blob.core.windows.net/catalogdb-backups/CatalogDb_Full.bak' WITH FORMAT, INIT, COMPRESSION

# Step 3: Start online migration (LRS)
az datamigration sql-managed-instance create --resource-group sql-migrate-rg --managed-instance-name eshop-sqlmi --target-db-name "Microsoft.eShopOnWeb.CatalogDb" --migration-service "..." --scope "..." --source-database-name "Microsoft.eShopOnWeb.CatalogDb" --source-sql-connection authentication="SqlAuthentication" data-source="10.0.1.5" password="..." user-name="sa" encrypt-connection=true trust-server-certificate=true --source-location '{"AzureBlob":{"storageAccountResourceId":"...","accountKey":"...","blobContainerName":"catalogdb-backups"}}' --offline-configuration offline=false

# Step 4: Monitor status
az datamigration sql-managed-instance show --resource-group sql-migrate-rg --managed-instance-name eshop-sqlmi --target-db-name "Microsoft.eShopOnWeb.CatalogDb" --query "{DB:name, Status:properties.migrationStatus}" --output table

# Step 5: Take log backups continuously (LRS applies them to MI)
# BACKUP LOG [Microsoft.eShopOnWeb.CatalogDb] TO URL = N'https://eshopmibackups.blob.core.windows.net/catalogdb-backups/CatalogDb_Log1.bak' WITH FORMAT, INIT, COMPRESSION

# Step 6: When ready - trigger cutover
az datamigration sql-managed-instance cutover --resource-group sql-migrate-rg --managed-instance-name eshop-sqlmi --target-db-name "Microsoft.eShopOnWeb.CatalogDb" --migration-operation-id "75762407-28c6-41a0-b0c8-87dec6f00e5b"
