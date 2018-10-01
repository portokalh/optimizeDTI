%Load fiber_count file which should have values between 1 and 4 for number
%of fibers calculated in each voxel;

addpath('/Volumes/TrinityDrive/N51200_v2/NIfTI_20140122')
addpath('/Volumes/TrinityDrive/N51200_v2/altmany-export_fig-f13ef82')
angles = {'12' '15' '20' '30' '45' '60' '80' '100' '120'};
resolutions = {'_2x' '_4x'};
vox_sizes= {'80um' '160um'};
percents = {'50' '25'};
for rr = 1:length(resolutions)
    res=resolutions{rr};
    v_size=vox_sizes{rr};
    percent = percents{rr};
    main_prefix=['/Volumes/TrinityDrive/N51200_v2/kspace_downsampled_resolution/chass_downsampled' res ];
    for jj = 1:2
        jj
        
        out_array=zeros([166 numel(angles)]);
        for aa = 1:length(angles)
            angle=angles{aa}
            
            fiber_file=[main_prefix '/bedpost_ESR' angle res '/ESR' angle res '_fiber_count.nii.gz'];
            %fiber_file='/Volumes/TrinityDrive/N51200_v2/Downsampled_resolution/N51200_80um/bedpost50_ESR12.bedpostX/fiber_count.nii.gz';
            fiber_nii=load_untouch_nii(fiber_file);
            fiber_image=fiber_nii.img;
            
            
            %Load ROI folder which should contain all 166 labels;
            % We can use the same masks as the image-space downsampled data
            in_dir=['/Volumes/TrinityDrive/N51200_v2/Downsampled_resolution/N51200_' v_size '/ROI_masks/'];
            
            
            for i=1:166;
                %out_array(i,1)=i
                
                name_L = ['ROI_' sprintf('%03d',i) '_L_' percent '.nii.gz'];
                name_R = ['ROI_' sprintf('%03d',i) '_R_' percent '.nii.gz'];
                if jj == 1
                    L_nii=load_nii([in_dir name_L]);
                    L_image= L_nii.img;
                    current_file = [main_prefix '/ROI_fiber_counts' res '_Left.csv'];
                    roi_sum=sum(fiber_image(:).*L_image(:));
                    out_array(i,aa)=roi_sum;
                    
                else
                    
                    R_nii=load_nii([in_dir name_R]);
                    R_image=R_nii.img;
                    current_file = [main_prefix '/ROI_fiber_counts' res '_Right.csv'];
                    roi_sum=sum(fiber_image(:).*R_image(:));
                    out_array(i,aa)=roi_sum;
                end
            end
        end
        csvwrite(current_file,out_array);
    end
end

