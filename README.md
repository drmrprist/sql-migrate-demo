# sql-migrate-demo
## eShopOnWeb: SQL Server to Azure SQL Database Migration

## Repository Structure
- apps/       - eShopOnWeb .NET app (submodule)
- docker/     - Dockerfile, docker-compose, nginx
- discovery/  - SQL inventory scripts
- migration/  - DMS migration scripts
- validation/ - Reconciliation scripts
- cicd/       - GitHub Actions pipeline
- docs/       - Architecture and runbook

## Migration Results
- Source: SQL Server 2022 on Azure VM
- Target: Azure SQL Database S2
- Tool: Azure DMS with Self-hosted IR
- CatalogDb: 12 items migrated
- IdentityDb: 2 users, 1 role migrated
- Validation: 12/12 PASSED

## Quick Start
1. git clone --recurse-submodules https://github.com/drmrprist/sql-migrate-demo.git
2. cd docker && docker-compose -f docker-compose.onprem.yml up -d
3. python3 validation/reconciliation.py

## Azure Resources
- Resource Group: sql-migrate-rg (Southeast Asia)
- SQL Server: eshop-sqlserver-1781294732.database.windows.net
- DMS: eshop-dms-new with Self-hosted IR
- VM: eshop-onprem-vm (source simulation)
