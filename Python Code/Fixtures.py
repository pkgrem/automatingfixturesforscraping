import pyodbc

def read(conn):
    print("Read")
    cursor = conn.cursor()
    cursor.execute("select cleansheeturl from url")
    for row in cursor:
        print(f'row = {row}')
    print()

conn = pyodbc.connect(

        "Driver= {SQL Server Native Client 11.0};"
        "Server=localhost\FPL;"
        "Database=master;"
        "Trusted_Connection=yes"
)

read(conn)

conn.close()