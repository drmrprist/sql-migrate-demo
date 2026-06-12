-- SQL Server Discovery Inventory Script
SELECT name AS DatabaseName, state_desc, recovery_model_desc, compatibility_level, create_date FROM sys.databases WHERE name NOT IN ('master','tempdb','model','msdb');
USE [Microsoft.eShopOnWeb.CatalogDb];
SELECT t.name AS TableName, s.name AS SchemaName, p.rows AS TotalRows FROM sys.tables t JOIN sys.indexes i ON t.object_id = i.object_id JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id JOIN sys.schemas s ON t.schema_id = s.schema_id WHERE i.index_id <= 1 GROUP BY t.name, s.name, p.rows ORDER BY p.rows DESC;
SELECT type_desc AS ObjectType, COUNT(*) AS ObjectCount FROM sys.objects WHERE is_ms_shipped = 0 GROUP BY type_desc ORDER BY ObjectCount DESC;
SELECT fk.name AS ForeignKeyName, tp.name AS ParentTable, tr.name AS ReferencedTable FROM sys.foreign_keys fk JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id JOIN sys.tables tp ON fkc.parent_object_id = tp.object_id JOIN sys.tables tr ON fkc.referenced_object_id = tr.object_id;
SELECT t.name AS TableName, i.name AS IndexName, i.type_desc AS IndexType, i.is_unique AS IsUnique, i.is_primary_key AS IsPrimaryKey FROM sys.indexes i JOIN sys.tables t ON i.object_id = t.object_id WHERE i.name IS NOT NULL ORDER BY t.name;
SELECT name AS UserName, type_desc AS UserType, create_date FROM sys.database_principals WHERE type IN ('S','U','G') AND name NOT IN ('guest','INFORMATION_SCHEMA','sys','dbo');
