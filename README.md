<h1>PFAS-protein-MD-analysis</h1>

This repository contains all scripts used in the project for umbrella sampling and other analyses as listed below,

1.	Umbrella Sampling
2.	BLG residues bound to PFOA
3.	C-N distance
4.	Percent helicity

**<h3>Umbrella sampling (US)</h3>**

It contains the scripts used for pulling of the alpha helix residues and the scripts required to run umbrella sampling windows along with example files.

Usage
<code>us-0.in</code> is the colvar file for pulling the alpha helix residues using rmsd colvar.
Make sure that correct serial for the residues of interest is provided. 

<code>us-1.in</code> sets the rmsd to the desired value for the US windows using rmsd colvar.

After running the umbrella sampling window,<br>
To perform WHAM analysis, execute <code>z-100ns-wham.sh</code>. Make sure to provide the correct path for wham. 
An example input (metafile_100ns) and output (freefile_100ns) files are provided in the example directory. 

After running the WHAM analysis, <code>zz-100ns-get-histogram.sh</code> can be used to construct histograms for US windows. 

**<h3>BLG residues bound to PFOA</h3>**

<code>get-num-frames-when-bound-to-protein.tcl</code> calculates the number of frames for which the PFOA stays bound within 3 Å of BLG. 
It considers only those residues of BLG that lie within 3 Å of PFOA and calculates the frames using the input PSF and DCD files.

<code>all_frames_distance_PFOA_BLG_residues.tcl</code> calculates the number of frames for which the BLG residues stay within 3 Å of PFOA present near calyx.

The threshold (3 Å) can be modified by the user if required.

<code>freq_residues.py</code> is a python script that calculates the percentage of time for the bound residues of BLG.

**<h3>C-N distance</h3>**

<code>distance.tcl</code> can be used to calculate the distance between the carbon atom (-COO-) of PFOA and nitrogen atom (NH3+) of LYS60 of BLG using the PSF and DCD as input files over all frames of the trajectory.

Next, <code>count-avg-std.sh</code> can be used to calculate the average and standard deviation from the last 50% of trajectory. 


**<h3>Percent helicity</h3>**

<code>z-percent_helicity.tcl</code> calculates the percentage helicity of the alpha helix residues of BLG for the last frame of trajectory using PSF and DCD as input files.

Make sure to provide the correct selection of atoms corresponding to the alpha helix residues.

***For all the analyses, the input files should be in the same directory as that of the script or else the complete path to the input files must be provided.*** 


