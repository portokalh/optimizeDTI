

%run vector finder
nii4d=load_nii('/Volumes/TrinityDrive/N51710_v2/dtifit/dti_ESR12/data.nii');
%load 4d nii
volume=nii4d.img(:,:,:,1);
%extract indices from 4d nii
nii4d=make_nii(volume,nii4d.hdr.dime.pixdim(2:4),[0 0 0],nii4d.hdr.dime.datatype);
%save new 4d nii and save gradient table
[path,name,extension]=fileparts('/Volumes/TrinityDrive/N51710_v2/dtifit/dti_ESR12/data.nii');
namet='nogradient';
name_nii4d = [path '/' name '_' namet extension];
save_nii(nii4d,name_nii4d);