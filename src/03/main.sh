
if ! [ $# -eq 4 ]
then
    echo "мало оргументов, ожидаю 4 значения"
else
    re='(^[1-6]$)'
    if ! [[ $1 =~ $re ]] && [[ $2 =~ $re ]] && [[ $3 =~ $re ]] && [[ $4 =~ $re ]]
    then
        echo "нужно использовать цифры от 1 до 6"
    else
        if [[ $1 -eq $2 || $3 -eq $4 ]]
        then
            echo "Почти все, значения 1 и 2 позиции не должны совпадать, тоже замое с 3 и 4"
        else
            end='\033[0m'
            case $1 in
                    "1") param1='\033[107m';;
                    "2") param1='\033[41m';;
                    "3") param1='\033[42m';;
                    "4") param1='\033[104m';;
                    "5") param1='\033[45m';;
                    "6") param1='\033[40m';;
                    
            esac

            case $2 in
                    "1") param2='\033[97m';;
                    "2") param2='\033[91m';;
                    "3") param2='\033[92m';;
                    "4") param2='\033[96m';;
                    "5") param2='\033[95m';;
                    "6") param2='\033[96m';;
                     
            esac

            case $3 in
                    "1") param3='\033[107m';;
                    "2") param3='\033[41m';;
                    "3") param3='\033[42m';;
                    "4") param3='\033[104m';;
                    "5") param3='\033[45m';;
                    "6") param3='\033[40m';;
                    
            esac

            case $4 in
                    "1") param4='\033[97m';;
                    "2") param4='\033[91m';;
                    "3") param4='\033[92m';;
                    "4") param4='\033[96m';;
                    "5") param4='\033[95m';;
                    "6") param4='\033[96m';;
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
                echo -e $param1$param2 DATE = $param3$param4$(date) | awk '{print $2" "$3" "$4" "$5}'$end#текущее время в виде: 12 May 2020 12:24:36
                echo -e $param1$param2 UPTIME = $param3$param4$(uptime -p)$end #время работы системы
                echo -e $param1$param2 UPTIME_SEC = $param3$param4$(awk '{print $1}' /proc/uptime)$end #время работы системы в секундах)
                echo -e $param1$param2 IP = $param3$param4$(ip a | grep 'inet .*enp' | awk '{print $2}')$end #ip-адрес машины в любом из сетевых интерфейсов
                echo -e $param1$param2 MASK = $param3$param4$(netstat -rn | awk 'NR==4{print $3}')$end #сетевая маска
                echo -e $param1$param2 GATEWAY = $param3$param4$(ip -4 route show default | awk '{print $3}')$end #ip шлюза по умолчанию
                echo -e $param1$param2 RAM_TOTAL = $param3$param4$(grep MemTotal /proc/meminfo | awk '{printf "%.3f GB", $2/(1024*1024)}')$end #размер оперативной памяти в Гб
                echo -e $param1$param2RAM_USED = $param3$param4$(vmstat -s | grep 'used memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')$end #размер используемой памяти в Гб
                echo -e $param1$param2 RAM_FREE = $param3$param4$(vmstat -s | grep 'free memory' | awk '{printf "%.3f GB", $1/(1024*1024)}')$end #размер свободной памяти в Гб
                echo -e $param1$param2 SPACE_ROOT = $param3$param4$param3$param4$(df /root/ | awk '/\/$/ {printf "%.2f MB", $2/1024}')$end #размер рутового раздела в Mб
                echo -e $param1$param2SPACE_ROOT_USED = $param3$param4(df /root | awk '/\/$/ {printf "%.2f MB", $3/1024}')$end #размер занятого пространства рутового раздела в Mб
                echo -e $param1$param2SPACE_ROOT_FREE = $param3$param4(df /root/ | awk '/\/$/ {printf "%.2f MB", $4/1024}')$end #размер свободного пространства рутового раздела в Mб
            fi
        fi
    fi
