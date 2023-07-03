#!/bin/zsh
# This needs my_pymatgen to be activated before running
# Execute the program as ./get_8NearestNeighbours.sh <lattice parameter from bulk relaxation>

lp=$1 # Here the $1 is the user-inputted lattice parameter found out from bulk relaxation

python3 ~/.local/bin/vasputil_nearestneighbors -n 12 CONTCAR > all12NearestNeighbours.txt

awk -v CONVFMT=%.6f -v lp="$lp" '{if (NR<=2) print $0; else print $1,$2,$3,($3-(lp/sqrt(2))),($3-(lp/sqrt(2)))^2}' all12NearestNeighbours.txt > tmp

awk -v CONVFMT=%.6f -v lp="$lp" -v sum="0" '{
sum=sum+$4*$4} END{print lp/sqrt(2)"  <--Ideal first NN distance"
print sqrt(sum/(NR-2))"  <--Root mean squared error"}' tmp > tmp2

cat tmp tmp2 > all12NearestNeighbours.txt
rm tmp tmp2

tail -2 all12NearestNeighbours.txt

