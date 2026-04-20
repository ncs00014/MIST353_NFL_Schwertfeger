# get_teams_for_specified_fan.py
from get_db_connection import get_db_connection
import pymssql

def get_teams_for_specified_fan(nflfan_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    # Execute stored procedure using parameter tuple
    cursor.execute("exec procGetTeamsForSpecifiedFan %s", (nflfan_id))
    rows = cursor.fetchall()
    conn.close

    # Build list of results using index access
    results = [
        {
            "TeamName": row["TeamName"],      # TeamName
            "Conference": row["Conference"],    # Conference
            "Division": row["Division"],      # Division
            "TeamColors": row["TeamColors"],
            "PrimaryTeam": row["PrimaryTeam"]
        }
        for row in rows
    ]

    return {"data": results}