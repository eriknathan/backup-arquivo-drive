#!/usr/bin/env bash
#
# backup.sh - Script para realização e backups de senhas para o drive
#
# Autor: Erik Nathan | GitHub: @eriknathan
# ------------------------------------------------------------------------- #
# Descrição:
#  --------------------------------------------------------------
#  Comandos:
#  	 $ ./backup.sh -> chama o script do backup
#  --------------------------------------------------------------
#  Arquivios:
# 	 ├── libs
# 	 │   ├── details.sh - Detalhes (cores e títulos)
#    ├── backup.sh - script principal
# ------------------------------------------------------------------------- #
# Testado em:
#   bash 5.1.16
# ------------------------------------------------------------------------- #

# -------------------------------- IMPORTAÇÕES -------------------------------- #
source libs/details.sh
# ------------------------------------------------------------------------- #

# -------------------------------- VARIÁVEIS -------------------------------- #
# Carrega as variáveis de ambiente do arquivo .env
DATA_ATUAL=$(date +'%Y.%m.%d')
set -o allexport
source .env
set +o allexport
# -------------------------------- FUNÇÕES -------------------------------- #
function trapped () {
	echo -e "${COR_VERMELHO}Erro na linha $1${COR_RESET}"
	exit 1
}
trap 'trapped $LINENO' ERR

function valided_backup () {
	_title "BACKUP DE SENHAS PARA DRIVE"

	if [ -e "$NOME_BACKUP" ]; then
    	echo -e "${COR_MAGENTE}Backup já realizado.${COR_RESET}	 password-$DATA_ATUAL.kdbx"
		_line
	else
		backup
		_line
		 
		if [ -e "$NOME_BACKUP" ]; then
			echo -e "${COR_VERDE}BACKUP REALIZADO COM SUCESSO!${COR_RESET}"
			_line
		fi
	fi
}

function backup () {
	echo -e "${COR_CIANO}Data atual:${COR_RESET} $DATA_ATUAL"
	sleep 0.5
	_line
	echo -e "${COR_CIANO}Arquivo do Backup:${COR_RESET} $NOME_BACKUP"
	_line
	sleep 0.5
	echo -e "${COR_CIANO}Realizando Backup de senhas...${COR_RESET}"
	_line
	cp $PASSWORD $NOME_BACKUP
	limpando_arquivos
	alerta_discord
}

function limpando_arquivos () {
    all_files="$DRIVE"
    list_files=($(ls -t "$all_files"))
    first_ten_file=("${list_files[@]:0:10}")
	sleep 1
    echo -e "${COR_MAGENTE}Lipando backups antigos...${COR_RESET}"
	sleep 0.5
	_line

    for file in "${list_files[@]:10}"; do
        rm -f "$all_files/$file"
    done	
}

function alerta_discord () {
	echo -e "${COR_MAGENTE}Enviando alertas...${COR_RESET}"
	_line
	sleep 1

	if [ -e "$NOME_BACKUP" ]; then
        MENSAGEM="
--------------------------------
✅ BACKUP REALIZADO COM SUCESSO!
--------------------------------
- Nome do arquivo: $NOME_BACKUP
- Data: $DATA_ATUAL
- Link do Drive: $LINK_DRIVE
"
	else
		MENSAGEM="
----------------------------
❌ BACKUP NÃO FOI REALIZADO!
----------------------------
- Data: $DATA_ATUAL
"
	fi

	curl -X POST -d "content=$MENSAGEM" "$WEBHOOK"
}

# ------------------------------------------------------------------------- #

# -------------------------------- EXECUÇÃO -------------------------------- #
valided_backup
# ------------------------------------------------------------------------- #
