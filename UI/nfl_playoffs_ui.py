import streamlit as st

from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui
from validate_user_ui import validate_user_ui
from get_teams_for_specified_fan_ui import get_teams_for_specified_fan_ui
from schedule_game_ui import schedule_game_ui
from get_all_changes_made_by_specified_admin_ui import get_all_changes_made_by_specified_admin_ui


# =========================
# SESSION STATE INIT (IMPORTANT)
# =========================
if "app_user_id" not in st.session_state:
    st.session_state.app_user_id = None

if "app_user_fullname" not in st.session_state:
    st.session_state.app_user_fullname = None

if "app_user_role" not in st.session_state:
    st.session_state.app_user_role = "Guest"


# =========================
# HEADER
# =========================
st.title("NFL Playoffs App")
st.write(
    "Welcome to the NFL Playoffs App! Use the sidebar to navigate through different features "
    "and explore information about NFL teams, players, and playoff matchups."
)


# =========================
# SIDEBAR NAVIGATION
# =========================
with st.sidebar:
    st.title("NFL Playoff Functionalities")

    api_endpoint = st.selectbox(
        "Select a functionality:",
        [
            "Get Teams by Conference and Division",
            "Get Teams in Same Conference and Division as Specified Team",
            "Validate User",
            "Get Teams For Specified Fan",
            "Schedule Game",
            "Get All Changes Made by Specified Admin"
        ]
    )


# =========================
# ROUTING LOGIC
# =========================

if api_endpoint == "Get Teams by Conference and Division":
    get_teams_by_conference_division_ui()

elif api_endpoint == "Get Teams in Same Conference and Division as Specified Team":
    get_teams_in_same_conference_division_as_specified_team_ui()

elif api_endpoint == "Validate User":
    validate_user_ui()

elif api_endpoint == "Get Teams For Specified Fan":
    get_teams_for_specified_fan_ui()

elif api_endpoint == "Schedule Game":
    st.write("USER ID:", st.session_state.get("app_user_id"))
    st.write("ROLE:", st.session_state.get("app_user_role"))
    # Must be logged in
    if st.session_state.get("app_user_id") is None:
        st.warning("Please log in to access the Schedule a Game functionality.")

    # Must be admin
    elif str(st.session_state.get("app_user_role")).strip() != "NFLAdmin":
        st.warning("Only users with the NFL Admin role can access this functionality.")

    else:
        schedule_game_ui()


elif api_endpoint == "Get All Changes Made by Specified Admin":
    get_all_changes_made_by_specified_admin_ui()