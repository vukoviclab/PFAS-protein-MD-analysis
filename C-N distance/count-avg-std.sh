#calculates the average and standdard deviation of the distance values
awk 'BEGIN{s=0;}{s=s+$2;}END{print s/NR;}' last-50-percent-frames-distance.txt
awk '{sum+=$2; sumsq+=$2*$2} END {print sqrt(sumsq/NR - (sum/NR)^2)}' last-50-percent-frames-distance.txt
