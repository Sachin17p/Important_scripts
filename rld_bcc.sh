#!/bin/bash
# This needs my_pymatgen to be activated before running
# Execute the program as ./get_8NearestNeighbours.sh <lattice parameter from bulk relaxation>

lp=$1 # Here the $1 is user inputted lattice parameter found out from bulk relaxation

if [ ! -f CONTCAR ]; then
    echo "CONTCAR file not found. Please make sure it exists in the current directory."
    exit 1
fi

# python3 ~/bin/vasputil_nearestneighbors -n 8 CONTCAR > all8NearestNeighbours.txt
python3 ~/.local/bin/vasputil_nearestneighbors -n 8 CONTCAR > all8NearestNeighbours.txt
awk -v CONVFMT=%.6f -v lp="$lp" '{if (NR<=2) print $0; else print $1,$2,$3,($3-(lp*sqrt(3)/2)),($3-(lp*sqrt(3)/2))^2}' all8NearestNeighbours.txt > tmp

awk -v CONVFMT=%.6f -v lp="$lp" -v sum="0" '{
sum=sum+$4*$4} END{print lp*sqrt(3)/2"  <--Ideal first NN distance"
print sqrt(sum/(NR-2))"  <--Root mean squared error"}' tmp > tmp2

cat tmp tmp2 > all8NearestNeighbours.txt
rm tmp tmp2

tail -2 all8NearestNeighbours.txt

