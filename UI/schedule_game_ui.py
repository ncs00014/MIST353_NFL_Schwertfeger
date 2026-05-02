import streamlit as st
from fetch_data import get_data, post
from datetime import date, time

def schedule_game_ui():
    st.header("Schedule a Game")

    # must be logged in
    if "app_user_id" not in st.session_state:
        st.warning("You must validate/login first before scheduling a game.")
        return

    teams_df = get_data("get_all_teams/", {})
    stadiums_df = get_data("get_all_stadiums/", {})

    if teams_df is None or stadiums_df is None:
        st.error("Failed to load teams or stadiums.")
        return

    GAME_ROUNDS = ["Wild Card", "Divisional", "Conference", "Super Bowl"]

    # clean options
    team_options = dict(zip(teams_df["TeamName"], teams_df["TeamID"]))
    stadium_options = dict(zip(stadiums_df["StadiumName"], stadiums_df["StadiumID"]))

    home_team_name = st.selectbox("Select Home Team", list(team_options.keys()))
    away_team_name = st.selectbox("Select Away Team", list(team_options.keys()))
    stadium_name = st.selectbox("Select Stadium", list(stadium_options.keys()))
    game_round = st.selectbox("Select Game Round", GAME_ROUNDS)

    game_date = st.date_input("Select Game Date" , min_value=date.today())
    game_start_time = st. time_input("Select Game Start Time", value=time(13, 0))
    
    if st. button("Schedule Game"):
        if home_team_name == away_team_name:
            st.warning("Home team and away team cannot be the same. Please select different.")
            return

    home_team_id = team_options[home_team_name]
    away_team_id = team_options[away_team_name]
    stadium_id = stadium_options[stadium_name]
    
    parameters = {}
    parameters ["home_team_id"] = home_team_id
    parameters ["away_team_id"] = away_team_id
    parameters ["game_date"] = game_date.isoformat()
    parameters ["game_start_time"] = game_start_time.isoformat()
    parameters["stadium_id"] = stadium_id
    parameters ["game_round"] = game_round
    parameters ["nfl_admin_id"] = st.session_state.app_user_id

    response = post("schedule_game/", parameters)

    if response is not None and "status_message" in response:
        st. info(response["status_message"])
    else:
        st.error("An error occurred while scheduling the game. Please try again.")
    