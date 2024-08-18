.DEFAULT_GOAL := all
packages = main scripts notebooks

## Virtual Env:
VENV_NAME = abdomenct_seg
PYTHON3 = ./venv/abdomenct_seg/bin/python3
PIP = ./venv/abdomenct_seg/bin/pip3

.PHONY: install
install: dev_requirements.txt
		python3 -m venv ./venv/$(VENV_NAME)
		chmod +x ./venv/$(VENV_NAME)/bin/activate
		$(PIP) install --upgrade pip setuptools wheel
		$(PIP) install -r dev_requirements.txt

.PHONY: clean
clean:
		if exist "__pycache__" rm - rf __pycache__
		if exist rm -rf venv/*

.PHONY: format
format:
		isort $(packages)
		black $(packages)