%Load fa_nii file which should have fa values for each voxel;
addpath('/Volumes/TrinityDrive/N51200_v2/NIfTI_20140122')
output=['/Volumes/TrinityDrive/N51200_v2/kspace_downsampled_resolution/dyad_dispersion_export_from_matlab.xlsx'];
angles = {'12' '15' '20' '30' '45' '60' '80' '100' '120'};
resolutions = {'_2x' '_4x'};
vox_sizes= {'80um' '160um'};
percents = {'50' '25'};
ivec=[51,59,62,76,120,122];
out_array=zeros([ numel(resolutions) numel(angles) 4 numel(ivec)]);
for rr = 1:length(resolutions)
    res=resolutions{rr};
    v_size=vox_sizes{rr};
    percent = percents{rr};
    main_prefix=['/Volumes/TrinityDrive/N51200_v2/kspace_downsampled_resolution/chass_downsampled' res ];
    
    %Load ROI folder which should contain all 166 labels;
    in_dir=['/Volumes/TrinityDrive/N51200_v2/Downsampled_resolution/N51200_' v_size '/ROI_masks/'];
    
    for aa = 1:length(angles)
        angle=angles{aa}
        for dd = 1:4
            %fa_file='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR30.bedpostX/dyads3_dispersion.nii.gz';
            fa_file=[main_prefix '/bedpost_ESR' angle res '.bedpostX/dyads' num2str(dd) '_dispersion.nii.gz'];
            fa_nii=load_untouch_nii(fa_file);
            fa_image=fa_nii.img;

            %Load ROI folder which should contain all 166 labels;
            %in_dir='/Volumes/TrinityDrive/N51200_v2/Brain_masks/Wholebrain_labels_no_BLA/';

            

            for i=1:length(ivec);
                label=ivec(i);

                out_array(rr,aa,dd,i,1)=label;
                label;
                name_L = ['ROI_' sprintf('%03d',label) '_L_' percent '.nii.gz'];
                name_R = ['ROI_' sprintf('%03d',label) '_R_' percent '.nii.gz'];

                L_nii=load_nii([in_dir name_L]); 
                L_image= single(L_nii.img);

                roi_sumL=sum(fa_image(:).*L_image(:));
                roi_volumeL=sum(L_image(:));
                current_roi_meanL=(roi_sumL/roi_volumeL);
                out_array(rr,aa,dd,i,2)=current_roi_meanL;


                R_nii=load_nii([in_dir name_R]);
                R_image=single(R_nii.img);

                roi_sumR=sum(fa_image(:).*R_image(:));
                roi_volumeR=sum(R_image(:));
                current_roi_meanR=(roi_sumR/roi_volumeR)
                out_array(rr,aa,dd,i,3)=current_roi_meanR;
                
                out_array(rr,aa,dd,i,4)=((roi_sumL+roi_sumR)/(roi_volumeL+roi_volumeR));

            end
        end
    end
end

res50_dyad1_L=squeeze(out_array(1,:,1,:,2))'
res50_dyad1_R=squeeze(out_array(1,:,1,:,3))'

res50_dyad2_L=squeeze(out_array(1,:,2,:,2))'
res50_dyad2_R=squeeze(out_array(1,:,2,:,3))'

res50_dyad3_L=squeeze(out_array(1,:,3,:,2))'
res50_dyad3_R=squeeze(out_array(1,:,3,:,3))'

res50_dyad4_L=squeeze(out_array(1,:,4,:,2))'
res50_dyad4_R=squeeze(out_array(1,:,4,:,3))'

res25_dyad1_L=squeeze(out_array(2,:,1,:,2))'
res25_dyad1_R=squeeze(out_array(2,:,1,:,3))'

res25_dyad2_L=squeeze(out_array(2,:,2,:,2))'
res25_dyad2_R=squeeze(out_array(2,:,2,:,3))'

res25_dyad3_L=squeeze(out_array(2,:,3,:,2))'
res25_dyad3_R=squeeze(out_array(2,:,3,:,3))'

res25_dyad4_L=squeeze(out_array(2,:,4,:,2))'
res25_dyad4_R=squeeze(out_array(2,:,4,:,3))'
