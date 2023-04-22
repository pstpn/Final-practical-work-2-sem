#!/bin/bash

# Инициализация кодов для подсветки вывода и каретки
yellow="\033[33m"
white="\033[37m"
clear_code="\033[K\r"
seek_code="\033[A"

# Создание папки исполняемых файлов
mkdir ./files_exe 2> trash.txt

# Названия программ
name_progs="[multi_matrix_1] [multi_matrix_2] [multi_matrix_3]"

#
# Обработка позиционных аргументов для задания новых параметров, при необходимости
# [DEFAULT]:
# sizes="25 50 75 100 125 150 175 200 \
# 225 250 275 300 325 350 375 400 425 \
# 450 475 500 525 550 575 600 625 650 675 700"
# 
if [ "$1" != "" ] && [ "$2" != "" ]; then
    sizes="$1"
    optimization="$2"
elif [ "$1" != "" ]; then
    sizes="$1"
    optimization="O1 O2 O3 O0 Os"
else
    sizes="25 50 75 100 125 150 175 200 \
    225 250 275 300 325 350 375 400 425 \
    450 475 500 525 550 575 600 625 650 675 700"
    optimization="O1 O2 O3 O0 Os"
fi

# Определение названий программ, которые необходимо собрать
for arg in "$@"; do
    if [ "$arg" == "-m" ]; then
        name_progs="[multi_matrix_1] [multi_matrix_2] [multi_matrix_3]"
        break
    elif [ "$arg" == "-a" ]; then
        name_progs="[addit_matrix_restrict] [addit_matrix]"
        break
    elif [ "$arg" == "-s" ]; then
        name_progs="[sort_matrix_cash] [sort_matrix]"
        break
    fi
done

echo -e "\n""$yellow""--[BUILDING APPS]--""$yellow""\n""$white"

for name in $name_progs; do
    for optim in $optimization; do
        for size in $sizes; do
            echo -n -e "$yellow""$name""$yellow""$white"" || $optim || $size""$clear_code""\r"

            # Сборка и компиляция программ
            gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal \
            -Wfloat-conversion -DMAX_SIZE="$size""ULL" -"$optim" \
            "$name".c -o ./files_exe/app"$name"_"$size"_"$optim".exe 2> trash.txt

            # Обработка ошибок при сборке
            if [ -s trash.txt ]; then
                echo -n -e "$clear_code""\r$seek_code""$seek_code""$clear_code""\r$seek_code""$seek_code"
                echo -e "\n\n""$yellow""--[ERROR]--""$yellow""\n""$white"
                exit 1
            fi
        done
    done
done

# Удаление мусорного файла
rm ./trash.txt
echo -n -e "$clear_code""\r$seek_code""$seek_code""$clear_code""\r$seek_code"