# Makefile para simular pipeline
.PHONY: install test lint format pipeline

install:
	@echo "Installing dependencies..."
	uv tool install tox --with tox-uv

test:
	@echo "Running tests..."
	uv tool run tox -e py312

lint:
	@echo "Running linting..."
	uv tool run tox -e lint

format:
	@echo "Running formatter..."
	uv tool run tox -e format

# Simula el pipeline completo
pipeline: test lint
	@echo "Pipeline completed successfully!"
