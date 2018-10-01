%Load b0 file which should be unmasked and include the whole skull;
b0_file='/Volumes/TrinityDrive/N51200_v2/RAS_DTI/9T_ESR6_approx_RAS/N51200_m000_DTI_ESR6_b0.nii';
b0_nii=load_untouch_nii(b0_file);
b0_image=b0_nii.img;


%Load brain mask;
mask_file='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_ESR12/nodif_brain_mask.nii';
mask_nii=load_untouch_nii(mask_file);
mask_image=mask_nii.img;
%make mask image integer16 data set;
mask_image2=im2int16(mask_image);


%Create new masked image by multiplying the two images;
brain=(b0_image.*mask_image2);
nii=make_nii(brain);
save_nii(nii,'/Volumes/TrinityDrive/N51200_v2/RAS_nii4D/nogradient_masked.nii.gz');