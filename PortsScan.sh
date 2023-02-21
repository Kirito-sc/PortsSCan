#!/bin/bash

#PortsScan

Green=`tput setaf 2`
Reset=`tput sgr0`

#./PortsScan  IP

IP=$1

echo -e "\n${Green} [Escaneando todos los puertos] \n"${Reset} 
nmap -p- -sS --min-rate 5000 $IP -oN allports.txt

PORTS=$(cat allports.txt |grep open |grep tcp |awk '{print $1}' FS=/ |xargs |tr ' ' ',')
echo -e "\n${Green} [Puertos abiertos : ${PORTS}] \n"${Reset}  

echo -e "\n${Green} [Servicios y posibles scripts...] \n"${Reset} 
nmap -p ${PORTS} -sV -sC $IP -oN services.txt 

echo -e "\n${Green} [EScaneando vulnerabilidades...] \n"${Reset} 
nmap -p ${PORTS} --script vuln $IP -oN vulns.txt 

mkdir PS
sudo mv *.txt PS

