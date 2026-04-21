import os
#import pyodbc
import pymssql
from dotenv import load_dotenv

# Load .env file
load_dotenv()

def get_db_connection():
    input_server = os.getenv("DB_SERVER")
    input_database = os.getenv("DB_NAME")
    input_user = os.getenv("DB_LOGIN")
    input_password = os.getenv("DB_PASSWORD")

    #connection_string = f"DRIVER={{ODBC Driver 18 for SQL Server}};"f"SERVER={input_server};"f"DATABASE={input_database};"f"UID={input_user};"f"PWD={input_password};"
    #connection_string += "Encrypt=yes;TrustServerCertificate=yes;Connection Timeout=30;"
    print("Attempting to connect to server: " + input_server)
    #return pyodbc.connect(connection_string)
    return pymssql.connect(server=input_server, database=input_database, user=input_user, password=input_password, port=1433, autocommit=True, tds_version='7.4')