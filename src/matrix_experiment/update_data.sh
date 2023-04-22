#!/bin/bash

# Инициализация кодов для подсветки вывода и каретки
yellow="\033[33m"
white="\033[37m"
clear_code="\033[K\r"
seek_code="\033[A"

# Данные для создания датасета по умолчанию
name_progs="[multi_matrix_1] [multi_matrix_2] [multi_matrix_3]"
sizes="25 50 75 100 125 150 175 200 \
225 250 275 300 325 350 375 400 425 \
450 475 500 525 550 575 600 625 650 675 700"
key="-m"
optimization="O1 O2 O3 O0 Os"
count=7

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

# Определение названий программ, у которых необходимо собрать датасет
for arg in "$@"; do
    if [ "$arg" == "-m" ]; then
        key="-m"
        name_progs="[multi_matrix_1] [multi_matrix_2] [multi_matrix_3]"
        break
    elif [ "$arg" == "-a" ]; then
        key="-a"
        name_progs="[addit_matrix_restrict] [addit_matrix]"
        break
    elif [ "$arg" == "-s" ]; then
        key="-s"
        name_progs="[sort_matrix_cash] [sort_matrix]"
        break
    fi
done

# Создание папки датасета
mkdir ./data 2> trash.txt

echo -e "\n""$yellow""--[UPDATING DATA]--""$yellow""\n""$white"

for num in $(seq "$count"); do
    for name in $name_progs; do
        for optim in $optimization; do
            for size in $sizes; do
                # Создание исполняемого файла с заданными параметрами, если его нет
                if [ ! -f ./files_exe/app"$name"_"$size"_"$optim".exe ]; then
                    if ! ./build_apps.sh "$sizes" "$optimization" "$key"; then
                        exit 1
                    fi
                fi

                echo -n -e "$yellow""($num/$count) $name: ""$yellow""$white""$optim $size""$clear_code"

                # Запуск программы для получения времени работы
                # echo -e "\n""app"$name"_"$size"_"$optim".exe\n"
                ./files_exe/app"$name"_"$size"_"$optim".exe \
                >> ./data/"$name"_"$optim"_"$size".txt 2> trash.txt
            done
        done
    done
done

# Удаление мусорного файла
rm ./trash.txt
echo -n -e "$clear_code""\r$seek_code""$seek_code""$clear_code""\r$seek_code"