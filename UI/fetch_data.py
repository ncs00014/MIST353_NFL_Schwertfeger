import streamlit as st
import requests
import pandas as pd

FASTAPI_url = "https://mist353-api-schwertfeger.azurewebsites.net" 


def get_data(endpoint: str, input_params: dict = None, method: str = "GET"):
    try:
        response = requests.get(
            f"{FASTAPI_url}/{endpoint}",
            params=input_params
        )

        if response.status_code == 200:
            payload = response.json()
            rows = payload.get("data", [])
            return pd.DataFrame(rows)

        else:
            st.error(f"Error fetching data: {response.status_code} - {response.text}")
            return None

    except requests.exceptions.RequestException as e:
        st.error(f"Request failed: {e}")
        return None


def post(endpoint: str, input_params: dict, method: str = "POST") -> dict:
    try:
        response = requests.post(
            f"{FASTAPI_url}/{endpoint}",
            params=input_params   # THIS IS THE KEY FIX
        )

        if response.status_code == 200:
            return response.json()
        else:
            st.error(f"Error posting data: {response.status_code}")
            st.error(response.text)
            return {
                "status_message": f"Error occurred: {response.status_code}",
                "detail": response.text
            }

    except requests.exceptions.RequestException as e:
        st.error(f"Request failed: {e}")
        return {}