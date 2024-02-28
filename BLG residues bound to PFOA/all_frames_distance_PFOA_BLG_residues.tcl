mol load psf  ../z-without-water.psf  pdb ../z-without-water.pdb
mol addfile   ../z-without-water-tot.dcd waitfor all


set sel1 [atomselect top "segname F7"]
set sel2 [atomselect top "protein and (same residue as protein and within 3 of segname F7)"]

set nf [molinfo top get numframes]

set com1 [measure center $sel1 weight mass]

set outfile [open all-frames-distance.csv w]

for {set i 0} {$i <= $nf} {incr i } {

  puts "frame $i of $nf"
  $sel1 frame $i
  $sel2 frame $i
  $sel1 update
  $sel2 update


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
    
    puts $outfile "$i, $uniqueresname$resID, $d1"
}
}
close $outfile
quit
