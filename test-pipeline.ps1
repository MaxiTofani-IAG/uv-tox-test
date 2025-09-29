# 🧪 Script para simular GitHub Actions localmente
# Ejecuta exactamente los mismos pasos que el YAML

Write-Host "🚀 SIMULANDO GITHUB ACTIONS LOCALMENTE" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

# Paso 1: Verificar Python
Write-Host "`n📋 Paso 1: Verificar Python" -ForegroundColor Yellow
python --version

# Paso 2: Verificar uv (ya instalado)
Write-Host "`n📋 Paso 2: Verificar uv" -ForegroundColor Yellow
uv --version

# Paso 3: Instalar tox con tox-uv (ya hecho)
Write-Host "`n📋 Paso 3: Verificar tox-uv" -ForegroundColor Yellow
uv tool run tox --version

# Paso 4: Ejecutar tests (igual que en GitHub Actions)
Write-Host "`n📋 Paso 4: Ejecutar tests" -ForegroundColor Yellow
Write-Host "Comando: tox -e py312" -ForegroundColor Cyan
uv tool run tox -e py312

# Paso 5: Ejecutar linting (igual que en GitHub Actions)
Write-Host "`n📋 Paso 5: Ejecutar linting" -ForegroundColor Yellow
Write-Host "Comando: tox -e lint" -ForegroundColor Cyan
uv tool run tox -e lint

Write-Host "`n[OK] PIPELINE SIMULADO COMPLETADO" -ForegroundColor Green
