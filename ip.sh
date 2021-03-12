#!/usr/bin/env bash

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done

ascii() {
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'
vermelho='\033[0;31m'
amarelo='\033[1;33m' 
NC='\033[0m'
clear      
echo -en """ $bld          
$amarelo    ▄▄▄         
$amarelo   ▀█▀██  ▄  
$amarelo ▀▄██████▀   
$amarelo    ▀█████   
$amarelo       ▀▀▀▀▄     
$amarelo                   
"""
}
script() {
ascii
echo -en """${NC}┌─ Olá. Insira o IP
└──╼ """
read ip
ascii
curl https://geolocation-db.com/json/8f12b5f0-2bc2-11eb-9444-076679b7aeb0/${ip} 2>/dev/null | jq .
}
coordenadas() {
  
latitude=$(curl https://geolocation-db.com/json/8f12b5f0-2bc2-11eb-9444-076679b7aeb0/${ip} 2>/dev/null | jq '.latitude')
longitude=$(curl https://geolocation-db.com/json/8f12b5f0-2bc2-11eb-9444-076679b7aeb0/${ip} 2>/dev/null | jq '.longitude')
echo " "
echo -en "${amarelo}λ ► Localização no Google Maps: ${NC}https://www.google.com.br/maps/@${latitude},${longitude},15z"
}

provedor(){
echo " "
internet=$(curl -fsSL http://ip-api.com/json/${ip} | jq '.isp')
echo -en "${amarelo}λ ► Provedor de Internet: ${NC}${internet}"
}

pergunta() {
sleep 1
echo " "
echo -en """
${vermelho}[0] ${NC}Abrir URL no Google Maps.
${vermelho}[1] ${NC}Sair do script.

-> """
read questao

case "$questao" in
    0|00"")
        open https://www.google.com.br/maps/@${latitude},${longitude},15z
    ;;
    1|01)
        
    ;;
    *)
;;
esac
}

script
provedor
coordenadas
pergunta