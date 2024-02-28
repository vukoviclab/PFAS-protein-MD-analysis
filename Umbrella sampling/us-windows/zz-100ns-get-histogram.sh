#!/bin/bash

for i in {25..600..25}
do
        cd zz-$i
        rm -rf rmsd-100ns.txt
        awk '(NR>1) && (($0 !~ /step/)) {print $2}' us-100.colvars.traj > rmsd-100ns.txt
        python3 hist-100ns.py

	cd ../
done

