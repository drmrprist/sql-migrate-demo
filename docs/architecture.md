# Architecture
## Source
NGINX->eShopOnWeb->SQL Server Docker
## Target
eShopOnWeb->Azure SQL Database
## Migration
Azure DMS with Self-hosted IR
## Validation
12/12 PASSED
## Network
VNet: eshop-vnet 10.0.0.0/16
Subnet: dms-subnet 10.0.1.0/24
VM Private IP: 10.0.1.5
## Cutover
1. Stop source app
2. Start app with Azure SQL strings
3. Verify HTTP 200
4. Run validation
## Limitations
Online migration not supported for SQL Server to Azure SQL DB
Recommend Azure SQL MI for zero-downtime migration
