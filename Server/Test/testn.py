import httpx

base_url = "http://localhost:8000"  # Reemplaza esto con la URL real de tu API

# Datos para el método POST /register
register_data = {
    "nombre": "Mario",
    "correo": "mario@example.com",
    "contraseña": "123"
}

# Datos para el método POST /token
login_data = {
    "correo": "mario@example.com",
    "contraseña": "123"
}

# Realiza la solicitud al método POST /register
response_register = httpx.post(f"{base_url}/register/", json=register_data)
print("POST /register Response:", response_register.json())

# Realiza la solicitud al método POST /token con formato JSON
response_token = httpx.post(f"{base_url}/token/", json=login_data)
token = response_token.json().get("access_token")
print("POST /token Response:", response_token.json())

# Asegúrate de que el token se haya obtenido correctamente
if token:
    # Realiza la solicitud al método POST /crear_entrada/ con el token en la cabecera
    entrada_data = {
        "ejeID": 1,
        "puntaje": 80,
        "diagnostico": "Entrada de prueba"
    }
    headers = {"Authorization": f"Bearer {token}"}
    response_crear_entrada = httpx.post(f"{base_url}/crear_entrada/", json=entrada_data, headers=headers)
    print("POST /crear_entrada/ Response:", response_crear_entrada.json())

    # Realiza la solicitud al método GET /users/me con el token en la cabecera
    response_get_user = httpx.get(f"{base_url}/users/me", headers=headers)

    # Imprime la respuesta
    if response_get_user.status_code == 200:
        print("GET /users/me Response:", response_get_user.json())
    else:
        print("GET /users/me Error:", response_get_user.text)
else:
    print("Token not obtained.")
