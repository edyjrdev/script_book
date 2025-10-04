#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo: gerar arquivo .sh executavel copiado do template.sh com chmod +x.

file=$1".sh"
cp ./util/template.sh $file

echo "Arquivo $file criado com sucesso com permissão de execução!"

