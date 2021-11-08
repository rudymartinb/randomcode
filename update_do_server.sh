#!/bin/bash

# imprime resultados a color. si falla muestra $SALIDA 
# para poder invocar una funcion hay q declararla antes.
resultado(){
    SALIDA=$1
    # SALIDA="sucutrule" # para probar el fail
    
    echo -e -n $2 

    # forzamos una columna arbitraria
    echo -e -n "\033[50D\033[30C "
    if [[ "$SALIDA" != "" || "$3" -ne "0" ]]; then
        echo -en "\033[107m"
        echo -en "\033[41m"
        echo "[ FAIL ]"
        echo -en "\033[39m"
        echo -en "\033[49m"
        echo -n "Error devuelto: " \"$SALIDA\"
        cat /tmp/curl.txt
        exit;
    fi  

    if [[ "$SALIDA" == "" ]]; then
        echo -en "\033[30m"
        echo -en "\033[42m"
        echo "[ OK ]"
        echo -en "\033[39m"
        echo -en "\033[49m"
    fi  
}

do_curl(){
    rm /tmp/curl.txt
    res=$(curl -v -X PUT "$1$2" --data-binary "@$3" --no-progress-meter 2>/tmp/curl.txt)
    resultado "$res" "\t$2 \t"  $?
    # cat /tmp/curl.txt
}

do_server(){

    SERVER=$1
    echo $SERVER :
    

    do_curl "http://$SERVER:7557/provisions/" default "/home/rudy/37sur/TR069_/provision/testing/provision.js" 
    do_curl "http://$SERVER:7557/provisions/" diag "/home/rudy/37sur/TR069_/provision/testing/diag.js" 
    do_curl "http://$SERVER:7557/provisions/" diag_complete "/home/rudy/37sur/TR069_/provision/testing/diag_complete.js"

}

