%Load fa_nii file which should have fa values for each voxel;
fa_file='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR12.bedpostX/mean_f1samples.nii.gz';
fa_nii=load_untouch_nii(fa_file);
fa_image=fa_nii.img;


%Load ROI folder which should contain all 166 labels;
in_dir='/Volumes/TrinityDrive/N51200_v2/Brain_masks/Wholebrain_labels_no_BLA/';


for i=1:166;
    out_array(i,1)=i;
    i
    name_L = ['ROI_' sprintf('%03d',i) '_L.nii.gz'];
    name_R = ['ROI_' sprintf('%03d',i) '_R.nii.gz'];
    
    L_nii=load_nii([in_dir name_L]); 
    L_image= single(L_nii.img);
    
    roi_sum=sum(fa_image(:).*L_image(:));
    roi_volumeL=sum(L_image(:));
    current_roi_meanL=(roi_sum/roi_volumeL)
    out_array(i,2)=current_roi_meanL;
    
    
    R_nii=load_nii([in_dir name_R]);
    R_image=single(R_nii.img);
    
    roi_sum=sum(fa_image(:).*R_image(:));
    roi_volumeR=sum(R_image(:));
    current_roi_meanR=(roi_sum/roi_volumeR)
    out_array(i,3)=current_roi_meanR;
    
end