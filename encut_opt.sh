for i in `seq -w 370 30 520` # change the range needed
do
cat <<EOF >INCAR
SYSTEM = Cu :fcc
ISTART = 0
ICHARG = 2
LWAVE = .False.
LREAL = Auto
LCHARG = .False.
PREC = Accurate
NCORE = 4
KPAR = 1
ISPIN = 1
ALGO = Fast

ENCUT = $i
EDIFF = 1E-7
NELM = 100

IBRION = 2
ISIF = 3
NSW = 40

ISMEAR = 3
SIGMA = 0.25

EOF

mkdir $i
cp INCAR $i/
cp POSCAR $i/
cp POTCAR $i/
cp KPOINTS $i/
cd $i
nohup mpirun -np 12 vasp_std > log$i &
# post process 
E=`grep 'F' OSZICAR|tail -n 1 | awk '{ print $5}'`;
echo $i $E >>../incar-conv.txt
cd ..
done

