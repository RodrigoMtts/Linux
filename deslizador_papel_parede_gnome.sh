#!/bin/bash
# 
# Autor: Rodrigo Soares
# E-mail: rodrigo.matta.soares@gmail.com
# 
# Descrição: Comando para trocar o papel de parede em ambientes gnome. 
# 					 Todos os papeis de paredes devem estar na pasta /home/$USER/Imagens/slide/
# 					 Muito últil ao associar a teclas de atalhos.
#
# Parametros obrigatórios: "+" ou "-"

declare -A A_arqs
declare -a a_arqs

D_IMAGEM="/home/$USER/Imagens/slide/"

if ! [ "$1" = '+' -o "$1" = '-' ] ; then
    echo "ERRO: Os parametros são obrigatórios. Passe um dos sinais: +' ou - ."
    exit 1 
fi

if ! [ -d $D_IMAGEM ] ; then
    echo "ERRO: O diretório $D_IMAGEM não existe."
    exit 1
fi

papel_de_parede="$(gsettings get org.gnome.desktop.background picture-uri-dark)"
papel_de_parede=${papel_de_parede:1: -1}

for arq in $D_IMAGEM* ; do
    A_arqs[$arq]=${#A_arqs[@]}
    a_arqs[${#a_arqs[@]}]="$arq"
done

if [ ${#A_arqs[@]} -eq 0 ] ; then
    echo "ERRO: O diretório $D_IMAGEM está vazio."
    exit 1
fi

posicao=$(( ( ${A_arqs[$papel_de_parede]} + ${#A_arqs[@]} $1 1 ) % ${#A_arqs[@]} ))

gsettings set org.gnome.desktop.background picture-uri-dark ${a_arqs[$posicao]}
