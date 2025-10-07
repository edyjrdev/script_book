#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo Referencia a diretorios no linux

# . diretorio atual
echo "atual: $(ls -la .)."
# .. diretorio pai
echo "pai: $(ls -la ..)."
# ~ diretorio home do usuario
echo "home: $(ls -la ~)."

# ~ diretorio home do usuario
echo "root dir: $(sudo ls -la ~root)."
