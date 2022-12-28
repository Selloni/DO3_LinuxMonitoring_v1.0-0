#!/bin/bash#!/bin/bash
file="$(date +"%d_%m_%y_%H_%M_%S.status")"
touch $file
echo  HOSTNAME = $(hostname) >> file
echo  TIMEZONE = $(timedatectl | grep zone | awk '{print $3$4$5}') >> file
echo  USER = $(whoami) >> file
echo  OS = $(cat /etc/issue | awk '{print $1$2}') >> file
echo  DATE = $(date) | awk '{print $2" "$3" "$4" "$5}') >> file#текущее время в виде: 12 May 2020 12:24:36
echo  UPTIME = $(uptime -p) >> file#время работы системы
echo  UPTIME_SEC = $(awk '{print $1}' /proc/uptime) >> file#время работы системы в секундах)
echo  IP = $(ip a | grep 'inet .*enp' | awk '{print $2}') >> file#ip-адрес машины в любом из сетевых интерфейсов
echo  MASK = $(netstat -rn | awk 'NR==4{print $3}') >> file #сетевая маска
echo  GATEWAY = $(ip -4 route show default | awk '{print $3}') >> file#ip шлюза по умолчанию
echo  RAM_TOTAL = $(grep MemTotal /proc/meminfo | awk '{printf "%.3f GB", $2/(1024*1024)}') >> file #размер оперативной памяти в Гб
echo  RAM_USED = $(vmstat -s | grep 'used memory' | awk '{printf "%.3f GB", $1/(1024*1024)}') >> file#размер используемой памяти в Гб
echo  RAM_FREE = $(vmstat -s | grep 'free memory' | awk '{printf "%.3f GB", $1/(1024*1024)}') >> file#размер свободной памяти в Гб
echo  SPACE_ROOT = $(df /root/ | grep dev | awk '{printf"%.2fMB", $2/1024}') >> file#размер рутового раздела в Mб
echo  SPACE_ROOT_USED = (df /root/ | grep dev | awk '{printf"%.2fMB", $3/1024}') >> file#размер занятого пространства рутового раздела в Mб
echo  SPACE_ROOT_FREE = (df /root/ | grep dev | awk '{printf"%.2fMB", $4/1024}') >> file#размер свободного пространства рутового раздела в Mб

read -p "Do you want to save log in a file? (Y/N):" answer
if [[ $answer == Y || $answer == y ]]
then
    echo "file save :)"
else
    rm -rf $file
fi
