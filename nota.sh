#!/bin/bash

DB='/home/'$USER'/bin/testenota.txt'

case $1 in
	-l) echo "$(< $DB)" ; exit 0 ;;	
	-e) vim "+normal Go$(date '+%d/%m/%Y %H:%M:%S') -----------------------------------------------------------------------------------------------------------" $DB ; exit 0 ;;
	-i) less $DB ; exit 0 ;;
	-x) read -p 'Realmente deseja apagar as notas existente[y,s]?' var ; [[ $var =~ [sy] ]] && > $DB || echo 'Notas não apagadas' ; exit 0 ;;
	-b) cp $DB $DB$(date +%Y%m%d_%H%M%S).bak ; exit 0 ;;
	-h | --help)
					echo '-l Lista o conteúdo das notes
-e Mode edição
-i Modo visualização interativa
-x Exclui as notas atuais
-b faz Backup das notas atuais
-h Help'
esac
 
echo $(date '+%d/%m/%Y %H:%M:%S') "-----------------------------------------------------------------------------------------------------------

$@

" >> $DB

