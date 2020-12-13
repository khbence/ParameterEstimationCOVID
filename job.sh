#!/bin/sh
#SBATCH -N 1      # nodes requested
#SBATCH -n 1      # tasks requested
#SBATCH -p gpu	  # use the GPU partition
#SBATCH --gres=gpu:v100:1	#select 1 V100 GPU
#SBATCH -c 24      # cores requested
#SBATCH -o outfile-%j  # send stdout to outfile
#SBATCH -e errfile-%j  # send stderr to errfile


#Commands that you would execute
module load python/3.6
module load gcc/9.2.0
module load gpu/cuda/11.0rc
source /home/khbence/ParameterEstimationCOVID/paramsEnv/bin/activate
python3.6 /home/khbence/ParameterEstimationCOVID/parameterEstimationCovid.py >> directOut.txt