#!/bin/bash
# 
# Autor: Rodrigo Soares
# 
# Descrição:  Função externa que mostra os valores das variáveis utilizadas até o momento da chamada.
#
# Utilização: Use source para carregar a função e coloque on_debug em qualquer parte do código e, então,
#             o programa finalizará e mostrará o valor das variáveis instanciadas até o momento
#
# Parametros: Todos opcionais;
#             Ao passar o nome de algumas variável apenas os valores delas serão mostrados; e
#             Use -r para inverter o dito acima.
#             
# ATENÇÃO:    No final dos valores sempre aparecerá um - (traço). Assim múltiplos espaços serão visíveis.

on_debug(){
    variaveisOnDebug="$(
        sed -n "1,${BASH_LINENO[0]}p" "${BASH_SOURCE[1]}" |
        grep -Eo '\b[[:alnum:]_]+=' |
        sort | 
        uniq |
        tr -d '='
    )"

    if [ "$1" = '-r' ] ; then
        shift
        parametrosOnDebug="$(tr ' ' '\n' <<< $*)"
        variaveisOnDebug="$(sort <<< "$variaveisOnDebug"$'\n'"$parametrosOnDebug" | uniq -u)"
    elif [ -n "$1" ] ; then
        parametrosOnDebug="$(tr ' ' '\n' <<< $*)"
        variaveisOnDebug="$(sort <<< "$variaveisOnDebug"$'\n'"$parametrosOnDebug" | uniq -d)"
    fi
    
    for varOnDebug in $variaveisOnDebug ; do
        echo "$varOnDebug=${!varOnDebug}"-
    done
    exit 0
}
