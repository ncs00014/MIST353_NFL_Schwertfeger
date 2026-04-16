# get_teams_for_specified_fan.py
from get_db_connection import get_db_connection
import pymssql

def get_teams_for_specified_fan(nflfan_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()

    # Execute stored procedure using parameter tuple
    cursor.callproc("{CALL GetTeamsForSpecifiedFan(?)}", (nflfan_id,))
    rows = cursor.fetchall()

    # Build list of results using index access
    results = [
        {
            "TeamName": row[0],      # TeamName
            "Conference": row[1],    # Conference
            "Division": row[2],      # Division
        }
        for row in rows
    ]

    # Close connection
    cursor.close()
    conn.close()

    return {"data": results}