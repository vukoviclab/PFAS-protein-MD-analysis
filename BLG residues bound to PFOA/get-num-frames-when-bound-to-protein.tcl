menu main on
mol load psf ../z-without-water.psf
mol addfile ../z-without-water-tot.dcd waitfor all

set outfile [open residue-vs-time.csv w]

set within_3A [atomselect top "protein and same residue as (protein and within 3 of resname FA)"]
#get the residues of protein
set RESIDUE [$within_3A get resid]
set unique_resids [lsort -unique $RESIDUE]

set num_frames [molinfo top get numframes]

set count 0
foreach Unique_Resid $unique_resids {
	for {set frame 0} {$frame < $num_frames} {incr frame} {
    $within_3A frame $frame
    
    # lassign [$within_3A get {resname resid}] resname resid

    if {[$within_3A num] > 0} {
        incr count
    }
}

set Time [expr $count/10]

puts "time with protein within 3 Å of FA: $Unique_Resid $Time"
puts $outfile "$Unique_Resid, $Time"
}
exit
