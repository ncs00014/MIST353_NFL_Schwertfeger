# UI/validate_user_ui.py
import streamlit as st
from fetch_data import get_data

def validate_user_ui():
    st.header("Validate User")

    email = st.text_input("Enter Email")
    password = st.text_input("Enter Password (hex, e.g., 01)", type="password")

    if st.button("Validate User"):
        if not email.strip():
            st.error("Email is required")
            return
        if not password.strip():
            st.error("Password is required")
            return

        # Convert to 0x format for SQL
        pwd_hex = password.strip()
        if not pwd_hex.startswith("0x"):
            pwd_hex = "0x" + pwd_hex

        input_params = {
            "email": email.strip(),
            "password_hash": pwd_hex
        }

        df = get_data("validate_user", input_params)

        if df is not None and not df.empty:
            st.success(f"User {email} is valid!")
            st.dataframe(df, use_container_width=True, hide_index=True)
            st.session_state.app_user_id= df["AppUserID"].values[0]
            st.session_state.app_user_fullname= df["Fullname"].values[0]
            st.session_state.app_user_role= df["UserRole"].values[0]
        else:
            st.info(f"User {email} is not valid. Please check the inputs and try again.")