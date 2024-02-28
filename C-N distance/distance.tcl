
#Provide paths to the PSF, PDB and DCD files
mol load psf  input.psf  pdb input.pdb 
mol addfile   ../../z-without-water-tot.dcd waitfor all

#atom selection for N atom of LYS 60
set sel1 [atomselect top "resname LYS and resid 60 and name NZ"] 
#atom selection for carbonyl acrbon of PFOA
set sel2 [atomselect top "segname F7 and name D12"]


set nf [molinfo top get numframes]

##################################################
# Loop over all frames.                          #
##################################################

set outfile [open last-50-percent-frames-distance.txt w]
#the range of $i can be modified according to the number of frames of interest
for {set i 10540} {$i <= $nf} {incr i 10} {

  puts "frame $i of $nf"
  $sel1 frame $i
  $sel2 frame $i
  $sel1 update
  $sel2 update

  set com1 [measure center $sel1 weight mass]
  set com2 [measure center $sel2 weight mass]

  set d1 [veclength [vecsub $com1 $com2]]
  set tim [expr $i/10]
  puts $outfile "$tim $d1"
  #puts $outfile "$i, $d1"
 
}
close $outfile

exit



