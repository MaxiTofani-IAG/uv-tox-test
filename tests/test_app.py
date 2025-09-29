# 🧪 Tests súper simples para aprender tox-uv

from fastapi.testclient import TestClient
from app import app

client = TestClient(app)


def test_home():
    """Test del endpoint principal"""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert data["message"] == "¡Hola! Esta es una API con tox-uv"
    assert data["status"] == "funcionando"


def test_health():
    """Test del endpoint de salud"""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "ok"
    assert data["app"] == "tox-uv-demo"


def test_suma():
    """Test del endpoint de suma"""
    response = client.get("/suma/5/3")
    assert response.status_code == 200
    data = response.json()
    assert data["a"] == 5
    assert data["b"] == 3
    assert data["suma"] == 8
