#!/bin/bash
START_TIME=$(date +%s)

if ! [ $# -eq 1 ]
then echo "нужно прописать путь к папке";
else
    if ! [[ $1 == */ ]]
    then echo "в конце должен использоваться /"
    else
        way=$1;
        function hesh {
            for ((i=1; i < 11; i++))
            do
                FILENAME="$(sudo find ${MY_PATH} -type f -name '*.exe' -exec du -sh {} + | sort -rh | head -$i | tail -1 | awk '{printf "%s", $2}')"
                if [[ -z "${FILENAME}" ]]; then
                    echo "Файлов c расширением \".exe\" нет"
                    break
                fi
                CURRENT_STR="$i - $(sudo find ${MY_PATH} -type f -name '*.exe' -exec du -sh {} + | sort -rh | head -$i | tail -1 | awk '{printf "%s, %s", $2, $1}')"
                MD5="$(md5sum ${FILENAME} | awk '{print $1}')"
                if [[ "${CURRENT_STR#*-}" == "${PREV_STR#*-}" ]]; then
                    break
                else
                    echo "${CURRENT_STR}, ${MD5}"
                    PREV_STR=$CURRENT_STR
                fi
            done
        }
        echo "Total number of folders (including all nested ones) = $(tree -a $way | grep directories | awk '{print $1}')"
        echo "TOP 5 folders of maximum size arranged in descending order (path and size): $(du -c $way | sort -rh | sed -n '3,8'p | awk '{print NR" - " $2 "/, " $1"K"}')" # sed -n'$'p - вывод строк / NR нумерация строк
        echo "etc up to = $(tree -a $way | grep file | awk '{print $3}')"
        echo "Number of:"
        echo "Configuration files (with the .conf extension) = $(tree -P '*.conf' | grep director | awk '{print $3}')"
        echo "Text files = $(tree -P '*.txt' $way | grep director | awk '{print $3}')"
        echo "Executable files = $(tree -P '*.sh' $way | grep director | awk '{print $3}')"
        echo "Log files (with the extension .log) = $(tree -P '*.log' $way | grep director | awk '{print $3}')"
        echo "Archive files = $(find $way -type f | grep "\.(zip|rar|gz|tar|7z)" | wc -l)"
        echo "Symbolic links = $(ls -la $way | grep -E '>' | awk '{print NR}' |  sed -n '$'p | awk '{print ($1/2)}')" #sed -n '$'p все файлы вроде
        echo "TOP 10 files of maximum size arranged in descending order (path, size and type): $(find -type f -exec ls -s {} \; | sort -hr | head -10 | awk -F. '{print NR" - "$0" "$NF}')" #NF информация сколько строк, ; $NF вывод последнего аргумента ; -F символ разделения
        echo "etc up to = $(tree -a $way | grep file | awk '{print $3}')"
        echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
        hesh  # внимательнее проверить, возможно не верная реализация
    fi
fi
END_TIME=$(date +%s)
DIFF=$(( $END_TIME - $START_TIME ))
echo "Script execution time (in seconds) = $DIFF"
