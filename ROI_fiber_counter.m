%Load fiber_count file which should have values between 1 and 4 for number
%of fibers calculated in each voxel;
fiber_file='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR45.bedpostX/fiber_count.nii.gz';
fiber_nii=load_untouch_nii(fiber_file);
fiber_image=fiber_nii.img;


%Load ROI folder which should contain all 166 labels;
in_dir='/Volumes/TrinityDrive/N51200_v2/Brain_masks/Wholebrain_labels_no_BLA/';


for i=1:166;
    out_array(i,1)=i;
    i
    name_L = ['ROI_' sprintf('%03d',i) '_L.nii.gz'];
    name_R = ['ROI_' sprintf('%03d',i) '_R.nii.gz'];
    
    L_nii=load_nii([in_dir name_L]); 
    L_image= L_nii.img;
    
    roi_sum=sum(fiber_image(:).*L_image(:));
    out_array(i,2)=roi_sum;
    
    
    R_nii=load_nii([in_dir name_R]);
    R_image=R_nii.img;
    
    roi_sum=sum(fiber_image(:).*R_image(:));
    out_array(i,3)=roi_sum;
    
    
end


