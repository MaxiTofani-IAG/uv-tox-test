# 🚀 Tox-UV Demo: FastAPI + Tox + UV

Este proyecto demuestra cómo usar **tox** con **tox-uv** para gestionar entornos virtuales y testing con una aplicación FastAPI de ejemplo.

## 📋 ¿Qué es tox y tox-uv?

- **tox**: Herramienta para automatizar testing en múltiples entornos Python
- **tox-uv**: Plugin que reemplaza `virtualenv` y `pip` con [uv](https://github.com/astral-sh/uv) (más rápido)

## 🛠️ Instalación

1. **Instalar tox con tox-uv:**
```bash
# Opción 1: Con uv (recomendado)
uv tool install tox --with tox-uv

# Opción 2: Con pip
pip install tox tox-uv
```

2. **Verificar instalación:**
```bash
tox --version
```

## 🎯 Comandos Tox Disponibles

### Testing
```bash
# Ejecutar todos los tests en Python 3.11 y 3.12
tox

# Ejecutar solo tests de Python 3.11
tox -e py311

# Ejecutar tests con pytest verbose
tox -e py311 -- -v -s
```

### Linting y Formateo
```bash
# Verificar formato del código
tox -e lint

# Formatear código automáticamente  
tox -e format

# Verificar tipos con mypy
tox -e type
```

### Desarrollo
```bash
# Crear entorno de desarrollo
tox -e dev

# Ejecutar la aplicación FastAPI
tox -e run
```

## 📁 Estructura del Proyecto

```
tox-test/
├── app.py              # 🎯 Aplicación FastAPI
├── tests/              # 🧪 Tests con pytest
│   ├── __init__.py
│   └── test_app.py
├── tox.ini             # ⚙️ Configuración de tox
├── pyproject.toml      # 📦 Dependencias y metadata
└── README.md           # 📖 Este archivo
```

## 🔧 Configuración tox.ini Explicada

### Entornos básicos de testing:
```ini
[testenv]
# Usa tox-uv automáticamente (más rápido que pip/virtualenv)
description = run tests with pytest
extras = test          # Instala dependencias de [project.optional-dependencies.test]
commands = pytest tests/ -v
```

### Entorno de linting:
```ini
[testenv:lint]
skip_install = true    # No instala el proyecto, solo las deps
deps = black>=23.0.0   # Dependencias específicas
```

## ⚡ Ventajas de tox-uv

1. **Velocidad**: `uv` es hasta 10-100x más rápido que `pip`
2. **Compatibilidad**: Drop-in replacement para `virtualenv` + `pip`
3. **Gestión de versiones**: Descarga automática de versiones Python

## 🧪 Probando la API

Una vez ejecutado `tox -e run`, puedes probar:

```bash
# Health check
curl http://localhost:8000/health

# Crear usuario
curl -X POST "http://localhost:8000/users" \
  -H "Content-Type: application/json" \
  -d '{"name": "Juan", "email": "juan@test.com", "age": 30}'

# Listar usuarios
curl http://localhost:8000/users
```

## 🎓 Conceptos Clave de tox

- **env_list**: Lista de entornos por defecto
- **testenv**: Configuración base para todos los entornos
- **extras**: Instala dependencias opcionales del pyproject.toml
- **commands**: Comandos a ejecutar en el entorno
- **skip_install**: No instala el proyecto (útil para linting)

## 🔍 Comandos Útiles de Debugging

```bash
# Listar todos los entornos disponibles
tox -l

# Recrear entornos (útil tras cambios en deps)
tox -r

# Ver qué hace tox paso a paso
tox -v

# Ejecutar comando específico en entorno
tox -e py311 -- python -c "import sys; print(sys.version)"
```

¡Ahora ya sabes usar tox y tox-uv! 🎉
