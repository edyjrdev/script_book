#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo: 

# executa o upgrade se o update tiver sucesso 

falha=0

# && - se o update retornar != falha executa upgrade
echo "Atualizando Ubuntu."
sudo apt update && sudo apt upgrade -y

# || - se o updade tiver falha imprime na tela
sudo apt update || echo "Falha na atualização"

