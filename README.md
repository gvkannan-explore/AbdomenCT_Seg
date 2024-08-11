# AbdomenCT_Seg
Objective: Processing, train and deploy a segmentation model for Abdomen CT using a subset from MICCAI FLARE 2022 Challenge.

Written by Vignesh Kannan (gvkannan.work@gmail.com)

Base requirements:
* Python 3.9+
* numpy < 2.0 ## For monai's transforms

Environment file for the experiment:
Required variables:
ROOT_DIR = Directory to where the *.nii files are stored.
VENV_DIR = Directory to the venv used for the work.

Expected Next-Steps:
1. Data-processing pipeline from download version to a pre-processed version ready for training.
2. Trainer pipeline for segmentation using pytorch / pytorch learning.
3. Docker image with the trained model weights to run inference.

References:
* MONAI Tutorials: https://github.com/Project-MONAI/tutorials
* Grand-Challenge: https://grand-challenge.org/