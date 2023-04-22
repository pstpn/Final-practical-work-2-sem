from importlib.metadata import files
import os
from pickletools import optimize
import shutil
import re
from tkinter.font import names

from requests import options


path_data = "./post_data/"
path_first_graph = path_data + "multi_matrix_graph/"
path_second_graph = path_data + "addit_matrix_graph/"
path_third_graph = path_data + "sort_matrix_graph/"


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


def linear_graph(data, name, optims, path):
    for opt in optims:
        with open(path + name + "_" + opt + ".txt", "w") as f:
            for cur in data:
                if name == cur[0] and opt == cur[2] and cur[1] == "avg":
                    f.write(str(cur[3]) + " " + str(cur[4]) + "\n")


for name in names:
    if name[1] == "m":
        linear_graph(data, name, optims, path_first_graph)
    elif name[1] == "a":
        linear_graph(data, name, optims, path_second_graph)
    else:
        linear_graph(data, name, optims, path_third_graph)
