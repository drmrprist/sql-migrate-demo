# eShopOnWeb — Database Migration Architect Assessment

On-prem SQL Server to Azure SQL Managed Instance — Online migration via LRS

## Live URLs

- Azure Cloud (live): https://eshop-web.thankfulhill-b86a41b2.southeastasia.azurecontainerapps.io
- Local Docker: http://localhost

## Quick start — run locally

git clone --recurse-submodules https://github.com/drmrprist/sql-migrate-demo.git
cd sql-migrate-demo
bash docs/run_local.sh

App available at http://localhost

## What this demonstrates

Complete Database Migration Architect assessment. eShopOnWeb .NET 8 migrated from on-prem SQL Server to Azure SQL Managed Instance using Log Replay Service (LRS) with zero downtime, then deployed to Azure Container Apps.

Phase 1 — On-prem simulation: Docker with NGINX, eShopOnWeb, SQL Server 2022. HTTP 200 at localhost.
Phase 2 — Discovery: SQL inventory, 8 tables, 4 FKs, 12 indexes, low risk.
Phase 3 — DB migration: LRS online migration, Azure VM to Azure SQL MI. Both DBs Succeeded.
Phase 4 — Live replication proof: Test record inserted during sync, confirmed in MI after cutover.
Phase 5 — Validation: 12/12 row count checks passed.
Phase 6 — CI/CD: GitHub Actions pipeline with migration gates.
Phase 7 — Cloud deployment: Azure Container Apps, Southeast Asia. Live URL above.

## Five methods tried before LRS succeeded

1. Direct DMS to Docker — Azure DMS cannot reach localhost, no network path
2. Cloudflare Tunnel — Free tier HTTPS only, SQL Server needs raw TCP
3. Transactional replication — Docker Developer Edition has no replication components
4. DMS sql-db online — Azure SQL Database is offline-only target, MS product limit
5. DMS sql-mi direct connect — Command is file-restore only, no live SQL connection
6. Log Replay Service (LRS) — SUCCEEDED. Backup to Blob, no direct network path needed.

## Migration architecture

Azure VM SQL Server (10.0.1.5)
  -> BACKUP DATABASE TO URL
  -> Azure Blob Storage (eshopmibackups)
       catalogdb-backups/CatalogDb_Full.bak (983 KB)
       catalogdb-backups/CatalogDb_Log1.bak (393 KB - includes test record)
       identitydb-backups/IdentityDb_Full.bak (983 KB)
  -> LRS continuous log apply
  -> Azure SQL Managed Instance (eshop-sqlmi)
       Microsoft.eShopOnWeb.CatalogDb - Online
       Microsoft.eShopOnWeb.Identity  - Online
  -> Azure Container Apps (eshop-web) - public HTTPS

## Validation

12/12 row count checks passed across CatalogDb and IdentityDb.
Script: validation/reconciliation.py

## Repository structure

apps/dotnet-eshop/         eShopOnWeb .NET 8 submodule
docker/                    Dockerfile, docker-compose, nginx.conf
discovery/                 SQL inventory scripts and results
migration/sqlserver/       LRS migration script and DMS scripts
validation/                reconciliation.py
cicd/                      GitHub Actions pipeline
docs/                      Architecture, runbook, screenshots, deliverables

## Resume line

Database Migration Architect Assessment — Migrated eShopOnWeb .NET 8 from on-prem SQL Server to Azure SQL Managed Instance using online LRS migration with zero downtime. Deployed to Azure Container Apps. 12/12 validation checks passed. github.com/drmrprist/sql-migrate-demo

## LinkedIn post

Just completed a hands-on Database Migration Architect assessment migrating eShopOnWeb .NET 8 from on-prem SQL Server to Azure SQL Managed Instance with zero downtime. Five methods were tried before Log Replay Service was identified as the correct path. Live demo at github.com/drmrprist/sql-migrate-demo

hashtags: DatabaseMigration Azure SQLServer AzureSQLMI CloudMigration DataEngineering DatabaseArchitect LRS

---
Candidate: drmrdba2026@gmail.com | Region: Southeast Asia | June 2026
