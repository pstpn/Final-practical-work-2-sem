#!/bin/bash

# Инициализация кодов для подсветки вывода и каретки
yellow="\033[33m"
white="\033[37m"
clear_code="\033[K\r"
seek_code="\033[A"

# Создание папки исполняемых файлов
mkdir ./files_exe 2> trash.txt

# Названия программ
name_progs="[index] [pointers] [array_pointers]"

#
# Обработка позиционных аргументов для задания новых параметров, при необходимости
# [DEFAULT]:
# sizes="1000 2000 3000 4000 5000 \
# 6000 7000 8000 9000 10000 \
# 11000 12000 13000 14000 15000 16000 17000"
# 
if [ "$1" != "" ] && [ "$2" != "" ]; then
    sizes="$1"
    optimization="$2"
elif [ "$1" != "" ]; then
    sizes="$1"
    optimization="O1 O2 O3 O0 Os"
else
    sizes="1000 2000 3000 4000 5000 \
    6000 7000 8000 9000 10000 \
    11000 12000 13000 14000 15000 16000 17000"
    optimization="O1 O2 O3 O0 Os"
fi

echo -e "\n""$yellow""--[BUILDING APPS]--""$yellow""\n""$white"

for name in $name_progs; do
    for optim in $optimization; do
        for size in $sizes; do
            echo -n -e "$yellow""$name""$yellow""$white"" || $optim || $size \r"

            # Сборка и компиляция программ
            gcc -std=c99 -Wall -Werror -Wpedantic -Wextra -Wfloat-equal \
            -Wfloat-conversion -DMAX_SIZE="$size""ULL" -"$optim" \
            main"$name".c -o ./files_exe/app"$name"_"$size"_"$optim".exe 2> trash.txt

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