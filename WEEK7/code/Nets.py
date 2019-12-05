#!/usr/bin/env python3

# Author: Y_Sun ys219@ic.ac.uk

"""python script that recreat the outcome of Nets.R"""

import pandas as pd
import networkx as nx
import matplotlib.pyplot as plt 

edge = pd.read_csv("../data/QMEE_Net_Mat_edges.csv")
node = pd.read_csv("../data/QMEE_Net_Mat_nodes.csv")
ids = list(node.id)
##load data and generate the ids

AdjList = []
#empty list for data

for i in range(len(edge)):
    for j in range(len(edge)):
        if edge.iloc[i][j] != 0 and i<j:
            AdjList.append((edge.columns[i],edge.columns[j],edge.iloc[i][j]))
## get directionalities and get rig of 0s, and repeated(ie. (icl,ceh)&(ceh,icl) keep only one) , and diagnals.

edgewidth = [i[2]/10+0.5 for i in AdjList]

nodescol = []
## empty list for nodes colours
for i in node.Type:
    if i == "University":
        nodescol.append("blue")
    elif i =="Hosting Partner":
        nodescol.append("green")
    else:
        nodescol.append("red")      

f = plt.figure()


## nodes layout
G = nx.Graph()
G.add_nodes_from(ids)
G.add_weighted_edges_from(tuple(AdjList))
## define the nodes and edge length

nx.draw_networkx(G,node_size = 2000, node_color = nodescol, edge_color = "grey",width = edgewidth)
## main network plot

red, = plt.plot([],"ro",markersize = 10)
green, = plt.plot([],"go",markersize = 10)
blue, = plt.plot([],"bo",markersize = 10)
plt.legend([red, green, blue,], ["Non-Hosting Partners","Hosting Partner", "University"], loc= "best")
## set the legend "ro","bo"for red dots blue dots

f.savefig("../results/QMEENet_by_py.svg", width = 10, height = 10)

