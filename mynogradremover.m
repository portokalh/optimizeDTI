%mygradremover
addpath('/Users/alex/Documents/MATLAB/alex/NIfTI_20140122/')
bvals12=dlmread('/Volumes/home/brain_data/ChrisLong/kspace_downsampled_resolution/chass_downsampled_4x/bedpost_ESR12_4x/bvals');
filename='/Volumes/home/brain_data/ChrisLong/kspace_downsampled_resolution/chass_downsampled_4x/bedpost_ESR12_4x/data.nii.gz'
res=gradient_remover_ab(filename,bvals12)

bvals45=dlmread('/Volumes/home/brain_data/ChrisLong/kspace_downsampled_resolution/chass_downsampled_4x/bedpost_ESR45_4x/bvals');
filename='/Volumes/home/brain_data/ChrisLong/kspace_downsampled_resolution/chass_downsampled_4x/bedpost_ESR45_4x/data.nii.gz'
res=gradient_remover_ab(filename,bvals45)

bvals120=dlmread('/Volumes/home/brain_data/ChrisLong/kspace_downsampled_resolution/chass_downsampled_4x/bedpost_ESR120_4x/bvals');
filename='/Volumes/home/brain_data/ChrisLong/kspace_downsampled_resolution/chass_downsampled_4x/bedpost_ESR120_4x/data.nii.gz'
res=gradient_remover_ab(filename,bvals120)


bvals12=dlmread('/Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR120/bvals');
filename='/Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR120/data.nii.gz';
res=nogradient_remover_ab(filename,bvals12)

bvals12=dlmread('/Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR12/bvals');
filename='/Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR12/data.nii.gz';
res=gradient_remover_ab(filename,bvals12)

bvals12=dlmread('/Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR45/bvals');
filename='/Volumes/home/brain_data/ChrisLong/N51200_v2/bedpost/bedpost_ESR45/data.nii.gz';
res=gradient_remover_ab(filename,bvals12)