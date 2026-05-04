import streamlit as st
from fetch_data import get_data

def get_all_changes_made_by_specified_admin_ui():

    st.header("Get All Changes Made by Specified Admin")

    # Input
    admin_id = st.text_input("Enter Admin ID")

    if st.button("Fetch Changes"):

        # Validate input first
        if not admin_id:
            st.error("Please enter an Admin ID")
            return

        # Build params (IMPORTANT: must match FastAPI exactly)
        input_params = {
            "nfladmin_id": admin_id   
        }

        # Debug (REMOVE later if you want)
        st.write("Sending request with:", input_params)

        # API call
        df = get_data(
            "get_all_changes_made_by_specified_admin",
            input_params
        )

        # Debug response
        st.write("Response:", df)

        # Output
        if df is not None and not df.empty:
            st.subheader(f"Changes made by Admin ID: {admin_id}")
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.info(f"No changes found for Admin ID {admin_id}.")