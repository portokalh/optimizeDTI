files={
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DSI_258_opt.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DSI_258_ic.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DSI_258_ac.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DSI_124_opt.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DSI_124_ic.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DSI_124_ac.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_120_opt.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_120_ic.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_120_ac.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_60_opt.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_60_ic.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_60_ac.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_30_opt.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_30_ic.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/hardi_30_ac.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DTI_12_opt.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DTI_12_ic.nii'...
'/Volumes/hellsblazes/Projects2/tractography_project/tdis/DTI_12_ac.nii'...
    };
  


protocol=[258 258 258 124 124 124 120 120 120 60 60 60 30 30 30 12 12 12];

reference='/Volumes/hellsblazes/Projects2/tractography_project/img/dti_12_b0.nii';

for i=1:length(files)
    switch protocol(i)
        case 12
            affine='';
            interp=0;
        case 30
            affine='/Volumes/hellsblazes/Projects2/tractography_project/img/hardi_30_b0_to_dti_12_b0_Affine.txt';
            interp=1;
        case 60
            affine='/Volumes/hellsblazes/Projects2/tractography_project/img/hardi_60_b0_to_dti_12_b0_Affine.txt';
            interp=1;
        case 120
            affine='/Volumes/hellsblazes/Projects2/tractography_project/img/hardi_120_b0_to_dti_12_b0_Affine.txt';
            interp=1;
        case 124
            affine='/Volumes/hellsblazes/Projects2/tractography_project/img/dsi_124_b0_to_dti_12_b0_Affine.txt';
            interp=1;
        case 258
            affine='/Volumes/hellsblazes/Projects2/tractography_project/img/dsi_258_b0_to_dti_12_b0_Affine.txt';
            interp=1;
    end
    [path name ext]=fileparts(files{i});
    output=[path '/' name '_reg.nii'];
    
    %roll_nii(files{i},[0 -roll],unrollpath);
    norm8bit_nii(files{i},output);
    if interp==1;
        apply_affine(output,affine,output,reference);
        convert_2_8bit(output);
    end
end

