#!/bin/bash

if  [ $# -ge 1 ]
then
    echo "слишком много аргументов"
else
    source config.cnf
    export L_fon=$column1_background
    export L_txt=$column1_font_color
    export R_fon=$column2_background
    export R_txt=$column2_font_color
    if [[ $L_fon == "" ]];
    then
    L_fon=6 ; column1_background="default"
    fi
    if [[ $L_txt == "" ]];
    then
        L_txtr=1 ; column1_font_color="default"
    fi
    if [[ $R_fon == "" ]];
    then
        R_fon=2 ; column2_background="default"
    fi
    if [[ $R_txt == "" ]];
    then
        R_txt=4 ; column2_font_color="default"
    fi

    re='(^[1-6]$)'
    if ! [[ $L_fon =~ $re ]] && [[ $L_txt =~ $re ]] && [[ $R_fon =~ $re ]] && [[ $R_txt =~ $re ]]
    then
        echo "нужно использовать цифры от 1 до 6"
    else
        if [[ $L_txt -eq $L_fon || $R_fon -eq $R_txt ]]
        then
            echo "Почти все, значения 1 и 2 позиции не должны совпадать, тоже замое с 3 и 4"
        else
        
            end='\033[0m'
            case $L_fon in
                    "1") param1='\033[107m'; L_fon_wr='white';;
                    "2") param1='\033[41m'; L_fon_wr='red';;
                    "3") param1='\033[42m'; L_fon_wr='green';;
                    "4") param1='\033[104m'; L_fon_wr='blue';;
                    "5") param1='\033[45m'; L_fon_wr='purple';;
                    "6") param1='\033[40m'; L_fon_wr='black';;
                    
            esac

            case $L_txt in
                    "1") param2='\033[97m'; L_txt_wr='white';;
                    "2") param2='\033[91m'; L_txt_wr='red';;
                    "3") param2='\033[92m'; L_txt_wr='green';;
                    "4") param2='\033[96m'; L_txt_wr='blue';;
                    "5") param2='\033[95m'; L_txt_wr='purple';;
                    "6") param2='\033[96m'; L_txt_wr='black';;
                     
            esac

            case $R_fon in
                    "1") param1='\033[107m'; R_fon_wr='white';;
                    "2") param1='\033[41m'; R_fon_wr='red';;
                    "3") param1='\033[42m'; R_fon_wr='green';;
                    "4") param1='\033[104m'; R_fon_wr='blue';;
                    "5") param1='\033[45m'; R_fon_wr='purple';;
                    "6") param1='\033[40m'; R_fon_wr='black';;
                    
            esac

            case $R_txt in
                    "1") param2='\033[97m'; R_txt_wr='white';;
                    "2") param2='\033[91m'; R_txt_wr='red';;
                    "3") param2='\033[92m'; R_txt_wr='green';;
                    "4") param2='\033[96m'; R_txt_wr='blue';;
                    "5") param2='\033[95m'; R_txt_wr='purple';;
                    "6") param2='\033[96m'; R_txt_wr='black';;
            esac
    #!/bin/bash#!/bin/bash
    #Обозначения цветов: (1 - white, 2 - red, 3 - green, 4 - blue, 5 – purple, 6 - black)
    #Параметр 1 - это фон названий значений (HOSTNAME, TIMEZONE, USER и т.д.)
    #Параметр 2 - это цвет шрифта названий значений (HOSTNAME, TIMEZONE, USER и т.д.)
    #Параметр 3 - это фон значений (после знака '=')
    #Параметр 4 - это цвет шрифта значений (после знака '=')
    #main.sh 1 2 3 4
                echo -e $param1$param2 HOSTNAME = $param3$param4$(hostname)$end
                echo -e $param1$param2 TIMEZONE = $param3$param4$(timedatectl | grep zone | awk '{print $3$4$5}')$end
                echo -e $param1$param2 USER = $param3$param4$(whoami)$end
                echo -e $param1$param2 OS = $param3$param4$(cat /etc/issue | awk '{print $1$2}')$end
                echo -e $param1$param2 DATE = $param3$param4$(date) | awk '{print $2" "$3" "$4" "$5}'$end #текущее время в виде: 12 May 2020 12:24:36
                echo -e $param1$param2 UPTIME = $param3$param4$(uptime -p)$end #время работы системы
                echo -e $param1$param2 UPTIME_SEC = $param3$param4$(awk '{print $1}' /proc/uptime)$end #время работы системы в секундах)
                echo -e $param1$param2 IP = $param3$param4$(ip a | grep 'inet .*enp' | awk '{print $2}')$end #ip-адрес машины в любом из сетевых интерфейсов
                echo -e $param1$param2 MASK = $param3$param4$(netstat -rn | awk 'NR==4{print $3}')$end #сетевая маска
                echo -e $param1$param2 GATEWAY = $param3$param4$(ip -4 route show default | awk '{print $3}')$end #ip шлюза по умолчанию
                echo -e $param1$param2 RAM_TOTAL = $param3$param4$(grep MemTotal /proc/meminfo | awk '{printf "%.3f GB", $2/(1024*1024)}')$end #размер оперативной памяти в Гб
                echo -e $param1$param2RAM_USED = $param3$param4$(vmstat -s | grep 'used memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')$end #размер используемой памяти в Гб
                echo -e $param1$param2 RAM_FREE = $param3$param4$(vmstat -s | grep 'free memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')$end #размер свободной памяти в Гб
                echo -e $param1$param2 SPACE_ROOT = $param3$param4$param3$param4$(df /root/ | grep dev | awk '{printf"%.2fMB", $2/1024}')$end #размер рутового раздела в Mб
                echo -e $param1$param2SPACE_ROOT_USED = $param3$param4$(df /root/ | grep dev | awk '{printf"%.2fMB", $3/1024}')$end #размер занятого пространства рутового раздела в Mб
                echo -e $param1$param2SPACE_ROOT_FREE = $param3$param4$(df /root/ | grep dev | awk '{printf"%.2fMB", $4/1024}')$end #размер свободного пространства рутового раздела в Mб
                echo ""
                echo "Column 1 background = $column1_background ($L_fon_wr)"
                echo "Column 1 font color = $column1_font_color ($L_txt_wr)"
                echo "Column 2 background = $column2_background ($R_fon_wr)"
                echo "Column 2 font color = $column2_font_color ($R_txt_wr)"
            fi
        fi
    fi
