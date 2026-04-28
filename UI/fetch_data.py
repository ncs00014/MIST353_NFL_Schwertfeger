import streamlit as st
import requests
import pandas as pd

FASTAPI_url = "http://localhost:8000"

def fetch_data(endpoint: str, input_params: dict = None, method: str = "GET"):
    try:
        if method.upper() == "GET":
            response = requests.get(f"{FASTAPI_url}/{endpoint}", params=input_params)
        elif method.upper() == "POST":
            response = requests.post(f"{FASTAPI_url}/{endpoint}", json=input_params)
        else:
            st.error(f"Unsupported HTTP method: {method}")
            return None

        if response.status_code == 200:
            payload = response.json()
            rows = payload.get("data", [])
            df = pd.DataFrame(rows)
            return df
        else:
            st.error(f"Error fetching data: {response.status_code} - {response.text}")
            return None

    except requests.exceptions.RequestException as e:
        st.error(f"Request failed: {e}")
        return None