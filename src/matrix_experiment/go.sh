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
if ! ./build_apps.sh "500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000" "O1 O2 O3 O0 Os" -a; then
    exit 1
fi
if ! ./build_apps.sh "10 25 50 75 100 125 150 175 200 225" "O1 O2 O3 O0 Os" -s; then
    exit 1
fi

# Обновление датасета
if ! ./update_data.sh; then
    exit 2
fi
if ! ./update_data.sh "500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000" "O1 O2 O3 O0 Os" 20 -a; then
    exit 2
fi
if ! ./update_data.sh "10 25 50 75 100 125 150 175 200 225" "O1 O2 O3 O0 Os" 20 -s; then
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
gnuplot -persist multi_matrix_graph.gpi
sleep 1
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"

# Построение второго графика
echo -e "\n""$yellow""--[BUILDING THE SECOND GRAPH]--""$yellow""$white"
gnuplot -persist addit_matrix_graph.gpi
sleep 1
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"

# Построение третьего графика
echo -e "\n""$yellow""--[BUILDING THE THIRD GRAPH]--""$yellow""$white"
gnuplot -persist sort_matrix_graph.gpi
sleep 1
echo -n -e "$clear_code""\r$seek_code""$clear_code""\r$seek_code"
