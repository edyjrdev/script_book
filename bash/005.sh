#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo: Enumeracoes {1..n}

segundos=5

data=$(date "+%Y%M%d%H%M%S")
echo "Iniciando em $data"


#criar arquivos de a ate e
echo "Cria arquivos"
touch $data-{a..e}.txt

echo 'Exibindo'
sleep $segundos

echo 'Deletando arquivos'
rm *.txt

# criar diretorios do ano atual
ano_atual=$(date '+%Y') 
# criando hierarquia diretorio ano atual
echo "criando diretorios para: $ano_atual"
mkdir -p $ano_atual/$ano_atual-{01..12}

sleep $segundos

echo "deletando diretorio: $ano_atual"
rm -rvf $ano_atual