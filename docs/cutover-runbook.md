# Cutover Runbook
## Pre-Cutover
- Validation 12/12 passed
- Azure SQL databases online
- DMS migration Succeeded
## Cutover Steps
1. Run validation script
2. Stop source app
3. Start app on Azure SQL
4. Test HTTP 200
5. Verify login
## Rollback
1. Stop Azure app
2. Restart source app
3. Verify reconnection
## Success Criteria
- HTTP 200 home page
- Login works
- Catalog loads 12 items
