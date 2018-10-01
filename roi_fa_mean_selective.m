%Load fa_nii file which should have fa values for each voxel;
fa_file='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR30.bedpostX/dyads3_dispersion.nii.gz';
fa_nii=load_untouch_nii(fa_file);
fa_image=fa_nii.img;


%Load ROI folder which should contain all 166 labels;
in_dir='/Volumes/TrinityDrive/N51200_v2/Brain_masks/Wholebrain_labels_no_BLA/';

ivec=[51,59,62,76,120,122];

for i=1:length(ivec);
    label=ivec(i);
    
    out_array(i,1)=label;
    label;
    name_L = ['ROI_' sprintf('%03d',label) '_L.nii.gz'];
    name_R = ['ROI_' sprintf('%03d',label) '_R.nii.gz'];
    
    L_nii=load_nii([in_dir name_L]); 
    L_image= single(L_nii.img);
    
    roi_sum=sum(fa_image(:).*L_image(:));
    roi_volumeL=sum(L_image(:));
    current_roi_meanL=(roi_sum/roi_volumeL);
    out_array(i,2)=current_roi_meanL;
    
    
    R_nii=load_nii([in_dir name_R]);
    R_image=single(R_nii.img);
    
    roi_sum=sum(fa_image(:).*R_image(:));
    roi_volumeR=sum(R_image(:));
    current_roi_meanR=(roi_sum/roi_volumeR)
    out_array(i,3)=current_roi_meanR;
    
end