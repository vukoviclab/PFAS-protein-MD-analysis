menu main on
mol load psf z-without-water.psf
mol addfile z-without-water-tot.dcd waitfor all

set outfile [open residue-vs-time.csv w]
set outfile1 [open residue-vs-frames.csv w]

set num_frames [molinfo top get numframes]

#initializing count that will store the number of frames
array set count {}

for {set frame 0} {$frame < $num_frames} {incr frame} {

    # Replace here the selection according to the resname or segname of the ligand in your input files (FA)
    set within_3A [atomselect top "protein and same residue as (protein and within 3 of resname FA)"]

    $within_3A frame $frame
    $within_3A update

    set RESIDUE [$within_3A get resid]
    set unique_resids [lsort -unique $RESIDUE]

    foreach Unique_Resid $unique_resids {
       
        if {[info exists count($Unique_Resid)]} {
            incr count($Unique_Resid)
        } else {
            set count($Unique_Resid) 1
        }
    }
}

foreach Unique_Resid [array names count] {
    set frames_count $count($Unique_Resid)
    set Time [expr $frames_count / 10.0]

    puts "time with protein within 3 Å of FA: $Unique_Resid $Time"
    puts $outfile "$Unique_Resid, $Time"
    puts $outfile1 "$Unique_Resid, $frames_count"
}

close $outfile
close $outfile1
exit

