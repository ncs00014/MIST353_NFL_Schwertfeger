import streamlit as st 
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
    # --- ADD THIS GUARD BLOCK ---
    if 'app_user_fullname' not in st.session_state:
        st.error("User information not found. Please go to the Home page and select a fan first.")
        return # This stops the rest of the code from running and crashing
    # -----------------------------

    fan_name = st.session_state.app_user_fullname
    st.header(f"Teams associated with {fan_name}")
    
    input_parameters = {}
    # Use .get() here as a second layer of safety
    fan_id = st.session_state.get("app_user_id", 0) 
    
    st.text_input("Fan ID", value=fan_id, disabled=True)
    input_parameters["nflfan_id"] = fan_id # Ensure this matches your API argument name

    # Note: Removed spaces from the endpoint string to prevent 404s
    df = fetch_data("get_teams_for_specified_fan/", input_parameters)

    if df is not None and not df.empty:
        st.dataframe(df, use_container_width=True, hide_index=True)
    else:
        st.info("No teams found for the specified fan.")