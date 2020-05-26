#!/bin/csh

set AMBERHOME="/home/guscafe/Documents/amber18" # put your local AMBERHOME here
set MDSTARTJOB=2
set MDENDJOB=10
set MDCURRENTJOB=$MDSTARTJOB
set MDINPUT=0

echo -n "Starting Script at: "
date
echo ""

while ( $MDCURRENTJOB <= $MDENDJOB )
   echo -n "Job $MDCURRENTJOB started at: "
   date
   @ MDINPUT = $MDCURRENTJOB - 1
   mpirun -np 4 $AMBERHOME/bin/sander.MPI -O -i DNA_md2.in \
                            -o Output/DNA_md$MDCURRENTJOB.out \
                            -p ../dna.prmtop \
                            -c Output/DNA_md$MDINPUT.ncrst \
                            -r Output/DNA_md$MDCURRENTJOB.ncrst \
                            -x Output/DNA_md$MDCURRENTJOB.nc
   gzip -9 -v DNA_md$MDCURRENTJOB.nc
   echo -n "Job $MDCURRENTJOB finished at: "
   date
   @ MDCURRENTJOB = $MDCURRENTJOB + 1
end
echo "ALL DONE"
