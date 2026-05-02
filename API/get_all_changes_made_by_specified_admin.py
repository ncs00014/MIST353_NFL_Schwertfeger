from get_db_connection import get_db_connection
import pymssql

def get_all_changes_made_by_specified_admin(nfladmin_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)

    try:
        # Execute stored procedure
        cursor.execute(
            "exec procGetAllChangesMadeBySpecifiedAdmin %s",
            (nfladmin_id,)
        )

        rows = cursor.fetchall()

    finally:
        conn.close()

    # Build structured response
    results = [
        {
            "ChangeDateTime": row["ChangeDateTime"],
            "ChangeType": row["ChangeType"],
            "ChangeDescription": row["ChangeDescription"],
            "GameRound": row["GameRound"],
            "GameDate": row["GameDate"],
            "GameStartTime": row["GameStartTime"],
            "HomeTeam": row["HomeTeam"],
            "AwayTeam": row["AwayTeam"],
            "StadiumName": row["StadiumName"]
        }
        for row in rows
    ]

    return {"data": results}