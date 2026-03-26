import os
import pyodbc
from dotenv import load_dotenv

# Load .env file
load_dotenv()

def get_db_connection():
    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_NAME")
    username = os.getenv("DB_LOGIN")
    password = os.getenv("DB_PASSWORD")

    if not all([server, database, username, password]):
        raise ValueError("Database environment variables are not set properly.")

    # Fixed connection string formatting (no newlines or leading spaces)
    connection_string = (
        f"DRIVER={{ODBC Driver 18 for SQL Server}};"
        f"SERVER={server};"
        f"DATABASE={database};"
        f"UID={username};"
        f"PWD={password};"
        f"TrustServerCertificate=yes;"
        f"Connection Timeout=30;"
    )

    # Connect and return the connection object
    try:
        conn = pyodbc.connect(connection_string)
        return conn
    except pyodbc.Error as e:
        print("Database connection failed:", e)
        raise