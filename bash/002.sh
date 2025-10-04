#!/usr/bin/env bash
# Template script for bash scripts

# Author: Edy Epumuceno Rodrigues Junior

# Objetivo: Backup de Pasta com tar.gz

#linux wsl
home_dir="/home/edyjr"

#backup no windows 
backup_dir="/mnt/c/t/backup"


mkdir -p $backup_dir

dia_atual=$(date '+%Y-%m-%d')

echo "Backup de $home_dir no arquivo $backup_dir/$dia_atual.tar.gz" 

# tar czf /mnt/c/t/backup/teste.tar.gz -C /home/edyjr .
tar czf $backup_dir/$dia_atual.tar.gz -C $home_dir .

echo "Backup concluído com sucesso!"

ls $backup_dir -lh


