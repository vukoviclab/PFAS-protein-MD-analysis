rm percent_helix.dat
# Set the output file path
set outfile_path "percent_helix.dat"

# Open the output file in append mode
set outfile [open $outfile_path a]

for {set r 25} {$r <= 600} {incr r 25} {
    cd ../zz-$r
    #path to input PSF and DCD files
    mol load psf fin.psf
    mol addfile us-2.dcd type dcd waitfor all

    set lookup {H G I}
    set frame_num [molinfo top get numframes]
    set full [atomselect top "name CA and resid 129 to 142"]
    set len [llength [$full get resid]]
    $full delete

    set last_frame [expr {$frame_num - 1}]

    animate goto $last_frame
    set sel [atomselect top "name CA and resid 129 to 142"]
    mol ssrecalc top
    set struc_string [$sel get structure]
    set helix 0

    foreach letter $lookup {
        set temp [expr {[llength [split $struc_string $letter]] - 1}]
        incr helix $temp
    }
set percent [expr {double($helix) / double($len) * 100}]
    puts $outfile "$r\t$percent"
    $sel delete

    cd ../percent_helicity
}
# Close the output file
close $outfile
exit
