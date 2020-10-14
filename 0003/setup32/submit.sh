bsub -J "setup32" -P cosem -n 5 -gpu "num=1" -q gpu_rtx -o output.log -e error.log -W 30240 ./run_train_cluster.sh unet_template.py ${@}
