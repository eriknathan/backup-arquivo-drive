# COR RESET
COR_RESET='\033[0m'

# CORES DE TEXTO
COR_PRET0='\033[0;30m'
COR_VERMELHO='\033[0;31m'
COR_VERDE='\033[0;32m'
COR_AMARELO='\033[0;33m'
COR_AZUL='\033[0;34m'
COR_MAGENTE='\033[0;35m'
COR_CIANO='\033[0;36m'
COR_BRANCO='\033[0;37m'

# CORES DE FUNDO
BG_COR_PRET0='\033[0;40m'
BG_COR_VERMELHO='\033[0;41m'
BG_COR_VERDE='\033[0;42m'
BG_COR_AZUL='\033[0;44m'
BG_COR_MAGENTE='\033[0;45m'
BG_COR_CIANO='\033[0;46m'
BG_COR_BRANCO='\033[0;47m'

# MODOS ASI
NORMAL='\033[0;0m'
NEGRITO='\033[0;1m'
BAIXA_INTENSID='\033[0;2m'
ITALICO='\033[0;3m'
SUBLINHADO='\033[0;4m'
PISCANDO='\033[0;5m'
PISCA_RAPIDO='\033[0;6m'
INVERSO='\033[0;7m'
INVISIVEL='\033[0;8m'

function _line () {
    local max_width=80
    printf "${COR_CIANO}%s${COR_RESET}\n" "$(printf '=%.0s' $(seq 1 "$max_width"))"
}


function _center_text () {
    local text="$1"
    local max_width=80
    local text_length=${#text}
    local padding=$(( (max_width - text_length) / 2 ))
    local padding_text=""
    
    for ((i=0; i<padding; i++)); do
        padding_text+=" "
    done
    
    printf "${COR_VERDE}%s${COR_RESET}\n" "$padding_text$text$padding_text"
}

function _title() {
    local text="$1"
    local max_width=80 
    local tam=${#text}
    local padding=$(( (max_width - tam) / 2 ))
    local padding_text=""
    
    for ((i=0; i<padding; i++)); do
        padding_text+=" "
    done
    
    printf "${COR_CIANO}%s${COR_RESET}\n" "$(printf '=%.0s' $(seq 1 "$max_width"))"
    printf "%s${COR_AMARELO}%s%s${COR_RESET}\n" "$padding_text" "${text^^}" "$padding_text"
    printf "${COR_CIANO}%s${COR_RESET}\n" "$(printf '=%.0s' $(seq 1 "$max_width"))"
}
