bsub -J "setup62" -P cosem -n 47 -gpu "num=1" -q gpu_t4 -o output.log -e error.log -W 30240 ./run_train_cluster.sh unet_template.py ${@}
