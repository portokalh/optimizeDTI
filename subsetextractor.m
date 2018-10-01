function volume=subsetextractor(path,majorgradienttable,inputtable,output_prefix)
%functionsubsetextractor (path,majorgradienttable,inputtable), path is a path to a 4d nii, input table is a
%subset of major table


[table,indices]=DTI_gradient_subselector(inputtable,majorgradienttable);
%run vector finder
nii4d=load_nii(path);
%load 4d nii
volume=nii4d.img(:,:,:,indices);
%extract indices from 4d nii
nii4d=make_nii(volume,nii4d.hdr.dime.pixdim(2:4),[0 0 0],nii4d.hdr.dime.datatype);
%save new 4d nii and save gradient table
[path,name,extension]=fileparts(path);
[patht,namet,extensiont]=fileparts(inputtable);
name_nii4d = [path '/' name '_' namet extension];
save_nii(nii4d,name_nii4d);

dti_toolkit_cmd = ['/Applications/Diffusion\ Toolkit.app/Contents/MacOS/dti_recon "' name_nii4d '" "/Volumes/TrinityDrive/' 'N51710_m000_DTI_' output_prefix '"  -gm "' table '" -b 4001.0865 -iop "/Volumes/TrinityDrive/9T_img_orient_patient.txt" -output_5d']
system(dti_toolkit_cmd)
