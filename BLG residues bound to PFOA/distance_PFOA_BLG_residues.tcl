mol load pdb z-last-frame.pdb
set sel1 [atomselect top "segname F7"]
set sel2 [atomselect top "protein and (same residue as protein and within 3 of segname F7)"]

set com1 [measure center $sel1 weight mass]

set outfile [open residues_within_3A_PFOA.txt w]

#Get the unique residues within the selection sel2
set Resid [$sel2 get resid]
set Uniqueresid [ lsort -unique $Resid]

#puts "+++++++++++++$Uniqueresid++++++++++++"

#Loop through the unique residues and calculate their center of mass
foreach resID $Uniqueresid {
    set selResidue [atomselect top "protein and resid  $resID"]
    set com2 [measure center $selResidue weight mass]

    #Get the residue name and residue ID (resID)
    set resname [$selResidue get resname]
   #set resid [$selResidue get resid]
    set uniqueresname [lsort -unique $resname]
     
    set d1 [veclength [vecsub $com1 $com2]]
    
    puts $outfile "$uniqueresname$resID, $d1"
}

close $outfile
quit
