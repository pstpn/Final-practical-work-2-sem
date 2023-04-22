from importlib.metadata import files
import os
from pickletools import optimize
import shutil
import re
from tkinter.font import names

from requests import options


path_data = "./post_data/"
path_first_graph = path_data + "first_graph/"
path_second_graph = path_data + "second_graph/"
path_third_graph = path_data + "third_graph/"


if not os.path.exists(path_data):
    os.mkdir(path_data)
else:
    shutil.rmtree(path_data)
    os.mkdir(path_data)
    
if not os.path.exists(path_first_graph):
    os.mkdir(path_first_graph)
else:
    shutil.rmtree(path_first_graph)
    os.mkdir(path_first_graph)
    
if not os.path.exists(path_second_graph):
    os.mkdir(path_second_graph)
else:
    shutil.rmtree(path_second_graph)
    os.mkdir(path_second_graph)
    
if not os.path.exists(path_third_graph):
    os.mkdir(path_third_graph)
else:
    shutil.rmtree(path_third_graph)
    os.mkdir(path_third_graph)
    

dirname = "./prep_data/"
files = os.listdir(dirname)


def get_data(dirname, files):
    data = [[0 for i in range(5)] for j in range(len(files))]
    names, optims, sizes = [], [], []
    
    for num, filename in enumerate(files):

        data[num][0] = re.findall(r'\[.+\]', filename)[0]
        data[num][1] = re.match(r'.+_\[', filename).group(0).replace("_", "").replace("[", "")
        data[num][2] = re.findall(r'O[0-3|s]', filename)[0]
        data[num][3] = int(re.findall(r'[1-9]+[0-9]*\.', filename)[0].replace(".", ""))
        
        with open(dirname + filename) as f:
            data[num][4] = float(f.readline().strip())
            
        if data[num][0] not in names:
            names += [data[num][0]]
            
        if data[num][2] not in optims:
            optims += [data[num][2]]
            
        if data[num][3] not in sizes:
            sizes += [data[num][3]]
    
    return data, names, optims, sizes


data, names, optims, sizes = get_data(dirname, files)
data.sort(key=lambda x: x[3])
sizes.sort()


def first_graph(data, names, optims):
    for name in names:
        for opt in optims:
            with open(path_first_graph + name + "_" + opt + ".txt", "w") as f:
                for cur in data:
                    if name == cur[0] and opt == cur[2] and cur[1] == "avg":
                        f.write(str(cur[3]) + " " + str(cur[4]) + "\n")



first_graph(data, names, optims)


def second_graph(data, names, sizes):
    cur_data = [0 for i in range(4)]
    for name in names:
        with open(path_second_graph + name + "_O2.txt", "w") as f:
            for size in sizes:
                cur_data[0] = str(size)
                for cur in data:
                    if cur[0] == name and cur[2] == "O2" and cur[3] == size:
                        if cur[1] == "avg":
                            cur_data[1] = str(cur[4])
                        elif cur[1] == "min":
                            cur_data[2] = str(cur[4])
                        elif cur[1] == "max":
                            cur_data[3] = str(cur[4])
                f.write(" ".join(cur_data) + "\n")
                        
                        
second_graph(data, names, sizes)


def third_graph(data, sizes):
    cur_data = [0 for i in range(7)]
    with open(path_third_graph + "[index]_O3.txt", "w") as f:
        for size in sizes:
            cur_data[0] = str(size)
            for cur in data:
                if cur[0] == "[index]" and cur[2] == "O3" \
                    and cur[3] == size:
                        if cur[1] == "min":
                            cur_data[1] = str(cur[4])
                        if cur[1] == "quartl":
                            cur_data[2] = str(cur[4])
                        if cur[1] == "median":
                            cur_data[3] = str(cur[4])
                        if cur[1] == "quarth":
                            cur_data[4] = str(cur[4])
                        if cur[1] == "max":
                            cur_data[5] = str(cur[4])
                        if cur[1] == "avg":
                            cur_data[6] = str(cur[4])
            f.write(" ".join(cur_data) + "\n")
            
            
third_graph(data, sizes)