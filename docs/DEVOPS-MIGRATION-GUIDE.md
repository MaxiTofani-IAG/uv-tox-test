# 🚀 GUÍA DEVOPS: Migración de Pipeline a tox-uv

## 📋 RESUMEN EJECUTIVO
- **Objetivo**: Migrar pipeline de `pip + virtualenv` a `tox-uv` 
- **Beneficio**: 10-100x más rápido en instalación de dependencias
- **Compatibilidad**: Drop-in replacement, mismos comandos
- **Riesgo**: Bajo (tox-uv es compatible con pip/virtualenv)

---

## 🔧 CAMBIOS EN PIPELINE

### ❌ ANTES (pip tradicional):
```yaml
# GitHub Actions / GitLab CI ejemplo
- name: Install dependencies
  run: |
    python -m pip install --upgrade pip
    pip install tox
    pip install -r requirements.txt

- name: Run tests
  run: tox -e py312
```

### ✅ DESPUÉS (con tox-uv):
```yaml
# GitHub Actions / GitLab CI ejemplo  
- name: Install uv
  run: |
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "$HOME/.local/bin" >> $GITHUB_PATH

- name: Install tox with tox-uv
  run: uv tool install tox --with tox-uv

- name: Run tests
  run: tox -e py312  # ¡Mismo comando!
```

---

## 📁 CAMBIOS EN ARCHIVOS

### 1. tox.ini - CAMBIOS OBLIGATORIOS

#### ❌ CONFIGURACIÓN ANTIGUA (NO funciona con tox-uv):
```ini
[tox]
envlist = py312
skipsdist = True  # ← ELIMINAR

[testenv]
deps =
    -r requirements.txt  # ← NO FUNCIONA con tox-uv
    pytest-cov
```

#### ✅ CONFIGURACIÓN NUEVA (compatible con tox-uv):
```ini
[tox]
envlist = py312
# skipsdist eliminado

[testenv]
extras = test  # ← Usa pyproject.toml
deps =
    pytest-cov
```

### 2. pyproject.toml - AGREGAR DEPENDENCIAS

```toml
[project]
dependencies = [
    "fastapi>=0.104.0",
    "uvicorn[standard]>=0.23.0", 
    "pydantic>=2.0.0",
]

[project.optional-dependencies]
test = [
    "pytest>=7.0.0",
    "pytest-asyncio>=0.21.0", 
    "httpx>=0.25.0",
    "pytest-cov>=4.0.0",
]
dev = [
    "black>=23.0.0",
    "flake8>=6.0.0",
    "mypy>=1.5.0", 
]
```

### 3. requirements.txt - OPCIONAL
- **Mantener**: Si otros procesos lo usan
- **Eliminar**: Si solo tox lo usaba

---

## 🐳 DOCKER

### ❌ DOCKERFILE ANTES:
```dockerfile
RUN pip install --upgrade pip
RUN pip install tox
COPY requirements.txt .
RUN pip install -r requirements.txt
```

### ✅ DOCKERFILE DESPUÉS:
```dockerfile
# Instalar uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Instalar tox con tox-uv
RUN uv tool install tox --with tox-uv

# Copiar archivos de configuración
COPY pyproject.toml tox.ini ./
```

---

## 🔄 COMANDOS DE MIGRACIÓN

### PIPELINE TÍPICO:

#### 1. Testing:
```bash
# Antes:
tox -e py312

# Después: 
tox -e py312  # ¡Mismo comando!
```

#### 2. Linting:
```bash
# Antes:
tox -e lint

# Después:
tox -e lint  # ¡Mismo comando!
```

#### 3. Coverage:
```bash
# Antes:
tox -e py312 -- --cov=app

# Después:
tox -e py312  # Ya incluye coverage
```

---

## ⚡ BENEFICIOS MEDIBLES

### VELOCIDAD:
- **Instalación deps**: 10-100x más rápido
- **Cache hits**: Mejor caching que pip
- **Resolución**: Resolver dependencias más rápido

### EJEMPLO DE MEJORA:
```bash
# ANTES (pip):
pip install -r requirements.txt  # ~60 segundos

# DESPUÉS (uv):
uv pip install -r requirements.txt  # ~3 segundos
```

---

## 🚨 POSIBLES PROBLEMAS Y SOLUCIONES

### 1. "No se encuentra uv"
```bash
# Solución:
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
```

### 2. "tox-uv no está instalado"
```bash
# Solución:
uv tool install tox --with tox-uv
```

### 3. "No encuentra dependencias"
```bash
# Problema: requirements.txt no funciona
# Solución: Migrar a pyproject.toml [project.optional-dependencies]
```

### 4. "Entorno no se crea"
```bash
# Solución: Limpiar cache
tox -e py312 --recreate
```

---

## 📊 CHECKLIST DE MIGRACIÓN

### PRE-MIGRACIÓN:
- [ ] Backup del pipeline actual
- [ ] Verificar que pyproject.toml existe
- [ ] Listar todas las dependencias actuales
- [ ] Documentar comandos actuales de CI/CD

### MIGRACIÓN:
- [ ] Instalar uv en pipeline
- [ ] Instalar tox-uv
- [ ] Modificar tox.ini (eliminar skipsdist, cambiar deps)
- [ ] Agregar dependencias a pyproject.toml
- [ ] Probar localmente

### POST-MIGRACIÓN:
- [ ] Ejecutar pipeline completo
- [ ] Verificar que tests pasan
- [ ] Medir mejora de velocidad
- [ ] Actualizar documentación

---

## 🎯 COMANDOS DE PRUEBA

### Probar localmente ANTES de hacer push:
```bash
# 1. Instalar herramientas
uv tool install tox --with tox-uv

# 2. Probar entornos individuales
tox -e py312
tox -e lint  
tox -e format

# 3. Probar pipeline completo
tox -e py312,lint,format

# 4. Limpiar y probar desde cero
tox --recreate
```

---

## 📞 SOPORTE

### Si algo falla:
1. **Verificar versiones**: `uv --version`, `tox --version`
2. **Limpiar cache**: `tox --recreate`
3. **Verbose mode**: `tox -v` para debug
4. **Comparar**: Ejecutar comando equivalente con pip

### Rollback rápido:
```bash
# Volver a pip tradicional:
pip install tox  # sin tox-uv
# Restaurar tox.ini anterior
```

---

## ✅ VALIDACIÓN FINAL

### El pipeline está migrado correctamente si:
- [ ] Tests pasan con mismos resultados
- [ ] Coverage reportes se generan
- [ ] Tiempo de ejecución mejoró
- [ ] No hay errores de dependencias
- [ ] Artifacts se generan correctamente

**¡Migración completada! 🎉**
