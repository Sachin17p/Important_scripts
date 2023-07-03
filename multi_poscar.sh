#!/bin/bash

percentage_changes=("${@:1:$#-1}") # Collect all arguments except the last one as an array
poscar_file=${@: -1} # Get the last argument as the POSCAR file name

for change in "${percentage_changes[@]}"; do
    scaling_factor=$(awk "BEGIN {printf \"%.10f\", ($change)^(1/3)}")
    output_file="poscar_${change//./_}.vasp" # Append the change value to the output file name

    # Read the second line of the POSCAR file, multiply the second element by the scaling factor
    # and create a new file with the modified second row
    awk 'NR==2{$0=sprintf("%.10f", scaling_factor)}1' scaling_factor="$scaling_factor" "$poscar_file" > "$output_file"

    echo "Generated $output_file with scaling factor $scaling_factor"
done
