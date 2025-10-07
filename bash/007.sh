#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo: Arrays

# array vazio
lista=()

lista[0]=1
lista[1]=3
lista[2]=7

echo "${lista[@]} tem ${#lista[@]} itens"

for n in "${lista[@]}"; do
    echo $n
done

lista_letras=('a' 'b' 'c' 'd' 'e')

echo "${lista_letras[@]} tem ${#lista_letras[@]} itens"

for l in "${lista_letras[@]}"; do
    echo $l
done
