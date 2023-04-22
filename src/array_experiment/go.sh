#!/bin/bash

# Инициализация кодов для подсветки вывода и каретки
yellow="\033[33m"
white="\033[37m"
clear_code="\033[K\r"
seek_code="\033[A"

# Сборка исполняемых файлов
if ! ./build_apps.sh; then
    exit 1
fi

# Обновление датасета
if ! ./update_data.sh; then
    exit 2
fi

# Препроцессирование
echo -e "\n""$yellow""--[MAKING PREPROCESSING]--""$yellow""$white"
python3 make_preproc.py
sleep 2
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"

# Постпроцессирование
echo -e "\n""$yellow""--[MAKING POSTPROCESSING]--""$yellow""$white"
python3 make_postproc.py
sleep 2
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"

# Построение первого графика
echo -e "\n""$yellow""--[BUILDING THE FIRST GRAPH]--""$yellow""$white"
gnuplot -persist first_graph.gpi
sleep 1
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"

# Построение второго графика
echo -e "\n""$yellow""--[BUILDING THE SECOND GRAPH]--""$yellow""$white"
gnuplot -persist second_graph.gpi
sleep 1
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"

# Построение третьего графика
echo -e "\n""$yellow""--[BUILDING THE THIRD GRAPH]--""$yellow""$white"
gnuplot -persist third_graph.gpi
sleep 1
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"
