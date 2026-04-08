import streamlit as st
import requests

def get_teams_for_specified_fan_ui():
    st.subheader("Get Teams for Specified Fan")
    nflfan_id = st.number_input("Enter NFL Fan ID:", min_value=1, step=1)

    if st.button("Get Teams"):
        try:
            response = requests.get(
                f"http://127.0.0.1:8000/get_teams_for_specified_fan/?nflfan_id={nflfan_id}"
            )
            if response.status_code == 200:
                result = response.json()
                data = result.get("data", [])  # <-- Extract 'data' list

                if data:
                    for team in data:
                        st.write(f"**Team Name:** {team.get('TeamName', 'N/A')}")
                        st.write(f"**Conference:** {team.get('Conference', 'N/A')}")
                        st.write(f"**Division:** {team.get('Division', 'N/A')}")
                        st.write("---")
                else:
                    st.warning("No teams found for this fan.")
            else:
                st.error(f"API returned {response.status_code}")
        except Exception as e:
            st.error(f"Error: {e}")