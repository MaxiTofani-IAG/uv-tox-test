# Script simple para probar pipeline localmente

Write-Host "SIMULANDO GITHUB ACTIONS LOCALMENTE" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green

Write-Host "Paso 1: Verificar Python" -ForegroundColor Yellow
python --version

Write-Host "Paso 2: Verificar uv" -ForegroundColor Yellow  
uv --version

Write-Host "Paso 3: Verificar tox-uv" -ForegroundColor Yellow
uv tool run tox --version

Write-Host "Paso 4: Ejecutar tests" -ForegroundColor Yellow
uv tool run tox -e py312

Write-Host "Paso 5: Ejecutar linting" -ForegroundColor Yellow
uv tool run tox -e lint

Write-Host "PIPELINE COMPLETADO" -ForegroundColor Green
