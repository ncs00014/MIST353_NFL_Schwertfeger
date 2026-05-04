import streamlit as st
from fetch_data import get_data

def get_teams_for_specified_fan_ui():

    st.header("Get Teams For Fan")

    fan_id = st.number_input("Enter Fan ID", min_value=1, step=1)

    fan_name = st.text_input("Fan Name (optional)")

    if st.button("Get Teams"):

        if not fan_id:
            st.error("Please enter a Fan ID")
            return

        input_parameters = {
            "nflfan_id": int(fan_id)
        }

        df = get_data("get_teams_for_specified_fan/", input_parameters)

        if df is not None and not df.empty:
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.info("No teams found for this fan.")