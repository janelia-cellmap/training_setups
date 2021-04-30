# Training Setups
Reference for parameters of the different training setups. Check the `summary.md` for each version for an overview of the configurations.

The underlying code base is [CNNectome](https://github.com/saalfeldlab/CNNectome/tree/v2.0) with corresponding docker images on [this dockerhub repo](https://hub.docker.com/repository/docker/neptunes5thmoon/cnnectome).
 
Model checkpoint files that have been used for segmentations on [openorganelle](https://openorganelle.janelia.org) are hosted on [s3://janelia-cosem-networks](https://open.quiltdata.com/b/janelia-cosem-networks/tree/).
To keep downloading the whole bucket manageable in terms of storage space, other checkpoints have not been included at this point. If you need different checkpoints, open an issue and we'll add them asap.
