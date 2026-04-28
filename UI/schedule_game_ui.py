import streamlit as st
from fetch_data import post_data


class ScheduleGameRequest(BaseModel):
    home_team_id: int
    away_team_id: int
    game_round: str
    game_date: date
    game_time: time
    stadium_id: int
    nfl_admin_id: int


def schedule_game(data: ScheduleGameRequest):
    conn = fetch_data()
    cursor = conn.cursor(as_dict=True)

    try:
        cursor.execute(
            "exec procScheduleGame %s, %s, %s, %s, %s, %s, %s",
            (
                data.home_team_id,
                data.away_team_id,
                data.game_round,
                data.game_date,
                data.game_time,
                data.stadium_id,
                data.nfl_admin_id,
            )
        )

        conn.commit()
        return {"status_message": "Game scheduled successfully."}

    except Exception as e:
        conn.rollback()
        return {"status_message": str(e)}

    finally:
        conn.close()