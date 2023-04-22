#!/bin/bash

# Инициализация кодов для подсветки вывода и каретки
yellow="\033[33m"
white="\033[37m"
clear_code="\033[K\r"
seek_code="\033[A"

# Данные для создания датасета по умолчанию
name_progs="[index] [pointers] [array_pointers]"
sizes="1000 2000 3000 4000 5000 \
6000 7000 8000 9000 10000 \
11000 12000 13000 14000 15000 16000 17000"
optimization="O1 O2 O3 O0 Os"
count=15

# Обработка позиционных аргументов для задания новых параметров, при необходимости
if [ "$1" != "" ]; then
    sizes="$1"
fi
if [ "$2" != "" ]; then
    optimization="$2"
fi
if [ "$3" != "" ]; then
    count="$3"
fi

# Сборка дополнительных исполняемых файлов, 
# если они заданы, как параметры командной строки
if [ "$#" == "1" ]; then
    ./build_apps.sh "$sizes"
elif [ "$#" == "2" ]; then
    ./build_apps.sh "$sizes" "$optimization"
fi

# Создание папки датасета
mkdir ./data 2> trash.txt

echo -e "\n""$yellow""--[UPDATING DATA]--""$yellow""\n""$white"

for num in $(seq "$count"); do
    for name in $name_progs; do
        for optim in $optimization; do
            for size in $sizes; do
                # Создание исполняемого файла с заданными параметрами, если его нет
                if [ ! -f ./files_exe/app"$name"_"$size"_"$optim".exe ]; then
                    if ! ./build_apps.sh "$sizes" "$optimization"; then
                        exit 1
                    fi
                fi

                echo -n -e "$yellow""($num/$count) $name: ""$yellow""$white""$optim $size""$clear_code"

                # Запуск программы для получения времени работы
                ./files_exe/app"$name"_"$size"_"$optim".exe \
                >> ./data/"$name"_"$optim"_"$size".txt 2> trash.txt
            done
        done
    done
done

# Удаление мусорного файла
rm ./trash.txt
echo -n -e "$clear_code""\r$seek_code""$seek_code""$clear_code""\r$seek_code"