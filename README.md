# 🚀 Tox-UV Demo

Proyecto de demostración que muestra cómo usar **tox** con **tox-uv** para automatizar testing y desarrollo con una aplicación FastAPI simple.

## ¿Qué hace este proyecto?

- **FastAPI simple**: API con endpoints básicos (`/`, `/health`, `/suma/{a}/{b}`)
- **Testing automatizado**: Tests con pytest y coverage
- **Linting**: Verificación de código con flake8 y black
- **Entornos aislados**: Gestión con tox usando uv (más rápido que pip)

## 🛠️ Instalación

```bash
# Instalar tox con soporte para uv
uv tool install tox --with tox-uv

# Verificar instalación
tox --version
```

## ⚙️ Configuración tox.ini para usar uv

La clave para usar **uv** en lugar de **pip** está en estas configuraciones del `tox.ini`:

```ini
[testenv]
# tox-uv reemplaza automáticamente pip/virtualenv con uv
extras = test          # Instala deps de [project.optional-dependencies.test]
commands = pytest {posargs:tests} -ra --cov=app

[testenv:lint]
skip_install = true    # Solo instala deps, no el proyecto
deps = flake8         # Dependencias específicas del entorno
commands = flake8 app.py tests

[testenv:run]
commands = uvicorn app:app --reload --port 8000
```

**Diferencias clave vs pip**:
- No necesitas `requirements.txt`, usa `extras` del `pyproject.toml`
- `tox-uv` automáticamente usa uv para instalar dependencias (10-100x más rápido)
- Misma sintaxis, mejor rendimiento

## 🔄 Workflow con tox

### Desarrollo local:
```bash
# 1. Ejecutar tests
tox -e py312

# 2. Verificar código
tox -e lint
tox -e format

# 3. Ejecutar aplicación
tox -e run
```

### En CI/CD (GitHub Actions):
```yaml
- name: Install uv
  uses: astral-sh/setup-uv@v6

- name: Install tox with tox-uv  
  run: uv tool install tox --with tox-uv

- name: Run tests
  run: tox -e py312

- name: Run linting  
  run: tox -e lint
```

## 🧪 Probar la API

```bash
# Ejecutar servidor
tox -e run

# En otra terminal:
curl http://localhost:8000/health
curl http://localhost:8000/suma/5/3
```

## 📋 Comandos útiles

```bash
tox -l          # Listar entornos disponibles
tox -r          # Recrear entornos
tox -e py312    # Ejecutar entorno específico
```
