#!bin/bash/

mkdir /Volumes/home/brain_data/ChrisLong/N51200_v2/dtifit_120_1x/
cd /Volumes/home/brain_data/ChrisLong/N51200_v2/dtifit_120_1x/
dtifit -k /Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR120/data.nii.gz -o /Volumes/home/brain_data/ChrisLong/N51200_v2/dtifit_120_1x/dtifit_120_1x -m /Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR120/nodif_brain_mask.nii.gz -r /Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR120/bvecs -b /Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR120/bvals 