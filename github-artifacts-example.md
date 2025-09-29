# 📊 Ejemplo: Cómo se ven los Artifacts en GitHub

## URL de ejemplo:
```
https://github.com/tu-usuario/tox-test/actions/runs/12345678
```

## Vista en GitHub Actions:

### 🏠 Página principal del repo
```
tu-usuario/tox-test
[Code] [Issues] [Pull requests] [Actions] [Projects] [Security] [Insights]
                                    ↑ Click aquí
```

### ⚡ Página de Actions
```
Actions
├── All workflows
├── CI Pipeline con tox-uv
│
Recent workflow runs:
├── ✅ CI Pipeline con tox-uv
│   │ Run #45 - main branch
│   │ Triggered by push - hace 5 minutos
│   │ Duration: 17s
│   └── [Click para ver detalles]
│
├── ✅ CI Pipeline con tox-uv  
│   │ Run #44 - feature/nueva-funcionalidad
│   │ Triggered by pull_request - hace 2 horas
│   │ Duration: 23s
│   └── [Click para ver detalles]
```

### 📋 Detalles del Run #45
```
✅ CI Pipeline con tox-uv #45

Summary:
- Commit: abc1234 "Add coverage artifacts"
- Branch: main
- Triggered by: push
- Duration: 17 seconds

Jobs:
├── ✅ test (17s)
│   ├── ✅ Set up Python 3.12
│   ├── ✅ Install uv  
│   ├── ✅ Install tox with tox-uv
│   ├── ✅ Run tests
│   ├── ✅ Run linting
│   ├── ✅ Upload coverage XML
│   └── ✅ Upload coverage HTML report

📊 Artifacts (2):
├── 📄 coverage-xml
│   │ Size: 2.1 KB
│   │ Expires in 30 days
│   └── [Download] ← Click para descargar
│
└── 🌐 coverage-html-report  
    │ Size: 47.3 KB
    │ Expires in 30 days
    └── [Download] ← Click para descargar
```

### 📥 Después de descargar:
```
Downloads/
├── coverage-xml.zip
│   └── coverage.xml
│
└── coverage-html-report.zip
    └── htmlcov/
        ├── index.html      ← Abrir en navegador
        ├── app_py.html
        ├── style.css
        └── ...
```
