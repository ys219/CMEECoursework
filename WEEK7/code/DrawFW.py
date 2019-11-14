import networkx as nx

import scipy as sc

import matplotlib.pyplot as p

def GenRdmAdjList(N = 2, C = 0.5):
    """ 
    """
    Ids = range(N)
    ALst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C:
            Lnk = sc.random.choice(Ids,2,replace=False).tolist()
            # if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops
            ALst.append(Lnk)
    
    return ALst


#c is the probablity of observe a connection btwn two random things. In nature it is 10-20%
###things in nature usually shown in log scale as it could be really dramatically vary in size
MaxN = 30
C = 0.75

AdjL = sc.array(GenRdmAdjList(MaxN , C))
AdjL

Sps = sc.unique(AdjL)
SizRan = ([-10,10])
Sizs =  sc.random.uniform(SizRan[0],SizRan[1],MaxN)
Sizs



pos = nx.circular_layout(Sps)

G = nx.Graph()

G.add_nodes_from(Sps)

G.add_edges_from(tuple(AdjL))

NodSizs = 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs))

nx.draw_networkx(G, pos, node_size= NodSizs, node_color="red", edge_color="black")
p.savefig("../results/FWnetwork.pdf")

