#!/bin/bash

CONDA_NAME=cghpipe

UNAME=$(uname)

if [ "$UNAME" == "Darwin" ]; then

	CONDASH=Miniconda3-latest-MacOSX-arm64.sh

elif [ "$UNAME" == "Linux" ]; then

	#CONDASH=Miniconda3-py39_24.7.1-0-Linux-x86_64.sh
	CONDASH=Miniconda3-latest-Linux-x86_64.sh

else

	echo "Unknown OS" $UNAME
	exit 0

fi

CONDAURL=https://repo.anaconda.com/miniconda/${CONDASH}

# conda:

if [ ! -e conda ]; then

	echo ">>> Setting up conda..."
	wget "${CONDAURL}"
	bash "${CONDASH}" -b -p conda
	rm -f "${CONDASH}"

fi

# install: conda

source conda/etc/profile.d/conda.sh
conda create -y -n $CONDA_NAME -c conda-forge -c bioconda cutadapt python=3.9
conda activate $CONDA_NAME
conda install -y r::r=2.12.1 #r::r-essentials

# #
# # N.B.; This `bioconda::ucsc-bedgraphtobigwig` *does not* work
# #


