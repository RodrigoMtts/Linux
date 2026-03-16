#!/bin/bash
# 
# Autor: RodrigoMtts
# 
# Descrição: Comando para trocar o papel de parede em ambientes gnome. 
# 		     Todos os papeis de paredes devem estar na pasta /home/$USER/Imagens/slide/
# 			 Muito últil ao associar a teclas de atalhos.
#
# Parametros obrigatórios: "+" ou "-"

D_IMAGEM='/home/'$USER'/Imagens/slide/'

if ! [ "$1" = '+' -o "$1" = '-' ] ; then
    echo "ERRO: Os parametros são obrigatórios. Passe um dos sinais: '+' ou '-'."
    exit 1 
fi

if ! [ -d $D_IMAGEM ] ; then
    echo 'ERRO: O diretório '$D_IMAGEM' não existe.' 
    exit 1
fi

papel_de_parede=$(gsettings get org.gnome.desktop.background picture-uri-dark)

quantidade=0
declare -a arqs
for arq in $D_IMAGEM* ; do
    arqs[$quantidade]="$arq"
    if [ "${papel_de_parede:8}" = "$arq""'" ] ; then
        posicao=$quantidade
    fi
    ((quantidade++))
done

if [ "${arqs[$posicao]}" = $D_IMAGEM'*' ] ; then
    echo 'ERRO: O diretório '$D_IMAGEM' está vazio.'
    exit 1
fi

posicao=$(( ( posicao + quantidade $1 1 ) % quantidade ))

gsettings set org.gnome.desktop.background picture-uri-dark 'file://'"${arqs[$posicao]}"
