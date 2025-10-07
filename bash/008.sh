#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo: lendo arquivos para array

arquivo="dados.csv"
touch $arquivo
echo "1;a" >> $arquivo
echo "2;b" >> $arquivo
echo "3;c" >> $arquivo

#cat $arquivo

# lendo arquivo linha por linha e armazenando num array
mapfile linhas < $arquivo

echo "Linhas:" ${linhas[@]}

lista_letras=('a' 'b' 'c' 'x' 'y' 'z')
# lendo array
read -a lista2 <<< ${lista_letras[@]} 
echo "Letras:" ${lista2[@]}
echo "Letra 1: " ${lista2[0]}
tam_letras=${#lista2[@]}
ultima_letra=$(( $tam_letras - 1))
echo "Letra $tam_letras: " ${lista2[$ultima_letra]}