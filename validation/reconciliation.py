import pyodbc, sys
SOURCE_CATALOG = "DRIVER={ODBC Driver 18 for SQL Server};SERVER=20.198.250.250;UID=sa;PWD=SourceDB@12345!;TrustServerCertificate=yes;DATABASE=Microsoft.eShopOnWeb.CatalogDb"
SOURCE_IDENTITY = "DRIVER={ODBC Driver 18 for SQL Server};SERVER=20.198.250.250;UID=sa;PWD=SourceDB@12345!;TrustServerCertificate=yes;DATABASE=Microsoft.eShopOnWeb.Identity"
TARGET_CATALOG = "DRIVER={ODBC Driver 18 for SQL Server};SERVER=eshop-sqlserver-1781294732.database.windows.net;UID=sqladmin;PWD=AzureDB@12345!;Encrypt=yes;TrustServerCertificate=no;DATABASE=eShopCatalogDb"
TARGET_IDENTITY = "DRIVER={ODBC Driver 18 for SQL Server};SERVER=eshop-sqlserver-1781294732.database.windows.net;UID=sqladmin;PWD=AzureDB@12345!;Encrypt=yes;TrustServerCertificate=no;DATABASE=eShopIdentityDb"
CATALOG = ["Catalog","CatalogBrands","CatalogTypes","Baskets","BasketItems","Orders","OrderItems"]
IDENTITY = ["AspNetUsers","AspNetRoles","AspNetUserRoles","AspNetRoleClaims","AspNetUserClaims"]
passed=0
failed=0
def check(src_conn,tgt_conn,tables,sdb,tdb):
    global passed,failed
    print(f"Validation: {sdb} -> {tdb}")
    src=src_conn.cursor()
    tgt=tgt_conn.cursor()
    for t in tables:
        src.execute(f"SELECT COUNT(*) FROM dbo.{t}")
        tgt.execute(f"SELECT COUNT(*) FROM dbo.{t}")
        sc=src.fetchone()[0]
        tc=tgt.fetchone()[0]
        r="PASS" if sc==tc else "FAIL"
        if sc==tc: passed+=1
        else: failed+=1
        print(f"  {t:<30} src={sc:<6} tgt={tc:<6} {r}")
try:
    sc=pyodbc.connect(SOURCE_CATALOG)
    si=pyodbc.connect(SOURCE_IDENTITY)
    tc=pyodbc.connect(TARGET_CATALOG)
    ti=pyodbc.connect(TARGET_IDENTITY)
    print("Connected to all databases")
    check(sc,tc,CATALOG,"Microsoft.eShopOnWeb.CatalogDb","eShopCatalogDb")
    check(si,ti,IDENTITY,"Microsoft.eShopOnWeb.Identity","eShopIdentityDb")
    print(f"SUMMARY: Passed={passed} Failed={failed}")
    print("ALL PASSED" if failed==0 else "SOME FAILED")
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)
