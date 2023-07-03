# Important_scripts
Scripts relevant to DFT calculations along with ATAT and Phonopy calculations. 
1. encut_opt.sh: Bash script for ENCUT optimization given KPOINTS.
2. eos.py: Python script for the equation of state calculations, namely Bulk Modulus, Equilibrium Lattice Parameter. It requires energy-volume
   data points in .xlsx format.
3. multi_poscar.sh: Bash script to generate POSCAR files for different volume shifts from equilibrium volume. You can use it as follows;
   bash multi_poscar.sh <1.03 1.01> CONTCAR 
   for +1% and +3% volume from equilibrium volume.
4. rld_bcc.sh: Bash script for calculation of RLD for BCC structures.
5. rld_fcc.sh: Bash script for calculation of RLD for FCC structures.
6. sbatch_commands.txt: SLURM job management system handy commands.
    
