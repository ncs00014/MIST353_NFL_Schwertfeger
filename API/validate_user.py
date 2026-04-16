from get_db_connection import get_db_connection
import pymssql

def validate_user(
    email: str,
    password_hash: str
    ):

    #with get_db_connection() as conn:
    conn = get_db_connection()
    cursor = conn.cursor()
    #cursor.execute("{CALL procValidateUser(?, ?)}", (email, password_hash))
    cursor.callproc("procGetTeamsByConferenceDivision", (email, password_hash))
    rows = cursor.fetchall()
    conn.close()

    # Convert pyodbc.Row objects to dicts
    results = [
        {
            "AppUserID": row["AppUserID"],
            "Fullname": row["Fullname"],
            "UserRole": row["UserRole"]
        }
        for row in rows
    ]

    return {"data": results}