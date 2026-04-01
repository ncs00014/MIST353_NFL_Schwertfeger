import streamlit as st
from fetch_data import fetch_data

def get_teams_by_conference_division_ui():
    st.header("Get Teams By Conference and Division")

    conference = st.selectbox("Select Conference", ["","AFC", "NFC"])
    division = st.selectbox("Select Division", ["","East","North", "South", "West"])

    if st.button("Fetch Teams"):
        input_params = {}
        input_params["conference"] = conference
        input_params["division"] = division

        df = fetch_data("get_teams_by_conference_division/", input_params)

        if df is not None and not df.empty:
                st.subheader(f"Teams in conference {conference}, division {division}:")
                st.dataframe(df, use_container_width = True, hide_index = True)
        else:
                st.info(f"No teams found in conference {conference}, division {division}. Please check the inputs and try again.")