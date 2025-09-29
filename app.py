# 🚀 FastAPI súper simple para aprender tox-uv

from fastapi import FastAPI

app = FastAPI(title="Tox-UV Demo", version="1.0.0")


@app.get("/")
def home():
    """Página principal"""
    return {
        "message": "¡Hola! Esta es una API con tox-uv",
        "status": "funcionando"
    }


@app.get("/health")
def health():
    """Endpoint de salud"""
    return {"status": "ok", "app": "tox-uv-demo"}


@app.get("/suma/{a}/{b}")
def sumar(a: int, b: int):
    """Suma dos números"""
    resultado = a + b
    return {"a": a, "b": b, "suma": resultado}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
