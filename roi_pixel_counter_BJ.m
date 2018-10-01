%Load fiber_count file which should have values between 1 and 4 for number
%of fibers calculated in each voxel;
addpath('/Volumes/TrinityDrive/N51200_v2/NIfTI_20140122')
addpath('/Volumes/TrinityDrive/N51200_v2/altmany-export_fig-f13ef82')
resolutions = {'_2x' '_4x'};
vox_sizes= {'80um' '160um'};
percents = {'50' '25'};
for rr = 1:length(resolutions)
    res=resolutions{rr};
    v_size=vox_sizes{rr};
    percent = percents{rr};
    main_prefix=['/Volumes/TrinityDrive/N51200_v2/kspace_downsampled_resolution/chass_downsampled' res ];
    
    %Load ROI folder which should contain all 166 labels;
    in_dir=['/Volumes/TrinityDrive/N51200_v2/Downsampled_resolution/N51200_' v_size '/ROI_masks/'];
    
    for i=1:166;
        %out_array(i,1)=i;
        i
        name_L = ['ROI_' sprintf('%03d',i) '_L_' percent '.nii.gz'];
        
        L_nii=load_nii([in_dir name_L]);
        L_image= L_nii.img;
        
        roi_sum=sum(1.*L_image(:));
        
        left_array(i)=roi_sum;
        
        name_R = ['ROI_' sprintf('%03d',i) '_R_' percent '.nii.gz'];
        R_nii=load_nii([in_dir name_R]);
        R_image=R_nii.img;
        
        roi_sum=sum(1.*R_image(:));
        right_array(i)=roi_sum;
        
        
    end
    left_file=[main_prefix '/ROI_voxel_counts' res '_Left.csv'];
    right_file=[main_prefix '/ROI_voxel_counts' res '_Right.csv'];
    csvwrite(left_file,left_array');
    csvwrite(right_file,right_array');
end