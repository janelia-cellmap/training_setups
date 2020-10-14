#!/usr/bin/env bash
WD=$(pwd)
RUNSCRIPT=${@}

echo "Starting as user ${USER_ID}"

singularity exec \
            --nv \
	    --containall \
	    -B /groups/saalfeld,/nrs/saalfeld,/groups/turaga,/groups/cosem/cosem,/nrs/cosem \
	    --pwd $WD \
	    /groups/saalfeld/home/heinrichl/singularity-builds/cnnectome.sif \
	    /bin/bash --norc -c "export OMP_NUM_THREADS=1; mprof run -T 1 -CM python -u $RUNSCRIPT 2>&1 | tee -a logfile"
