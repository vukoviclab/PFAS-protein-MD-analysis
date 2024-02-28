import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import numpy as np

# array defined within program
#theta=[77.438110,82.811340,59.701530,124.94859,82.991272,84.300468,24.639610,  112.28130]

# read position/energy data from a file
theta=[]
with open("rmsd-100ns.txt") as f:
    for line in f:
         theta.append(float(line))

num_bins = 100
hist_min = 0
hist_max = 20

# histogram the data
hist, bin_edges = np.histogram(theta, bins=num_bins, range=(hist_min, hist_max))

# print two 1-dimensional array elements into one 2-dimensional array
outhist = zip(bin_edges, hist)

# open file for writing
outf = open('rmsd-100ns.hist', 'w')

# write the rc and p(rc) into the output file
for i in outhist:
        outf.write(" ".join(str(x) for x in i) + "\n")

#print(hist)

# A way to plot histogram - doesn't work here - no GUI
#n, bins, patches = plt.hist(theta, num_bins, range=[0,180], normed = True,     histtype='bar',facecolor='green')
#plt.xlabel(r'$\theta$($\degree$)')
#plt.ylabel(r'$P(\theta)$')
#plt.show()
#savefig('foo.png')

