import os
import shutil
import numpy as np

path_data = "./prep_data/"

if not os.path.exists(path_data):
    os.mkdir(path_data)
else:
    shutil.rmtree(path_data)
    os.mkdir(path_data)

dirname = "./data/"
files = os.listdir(dirname)

optimizations = []
times = np.zeros([])

for i, filename in enumerate(files):
    with open(dirname + filename, "r") as f:
        times = np.array([int(i.strip()) for i in f])
    
    with open("./prep_data/avg_" + filename, "w") as z:
        z.write(str(sum(times) / len(times)))
        
    with open("./prep_data/median_" + filename, "w") as z:
        z.write(str(np.median(times)))
    
    with open("./prep_data/max_" + filename, "w") as z:
        z.write(str(max(times)))
        
    with open("./prep_data/min_" + filename, "w") as z:
        z.write(str(min(times)))
        
    with open("./prep_data/quartl_" + filename, "w") as z:
        z.write(str(np.quantile(times, 0.25)))
    
    with open("./prep_data/quarth_" + filename, "w") as z:
        z.write(str(np.quantile(times, 0.75)))