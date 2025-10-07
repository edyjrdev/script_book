#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo: Expressoes Matematicas

#calculando expressao e salvando em variavel
soma=$((100+20))

echo $soma

x=2
y=$x+3 # erro logico = concatena
echo $y

let y=x+3 # calcula

echo $y

echo $(( y =  x * 30 ))

echo $(( 1 < 0 )) # 0 - false
echo $(( 1 > 0 )) # 1 - true