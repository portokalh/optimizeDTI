function res=nogradientremover_ab(filename,bvals)

ind0=find(bvals~=0);

%filename='/Volumes/TrinityDrive/N51710_v2/dtifit/dti_ESR12/data.nii'
%run vector finder
nii4d=load_nii(filename);
%load 4d nii
volume=nii4d.img(:,:,:,ind0);
volume=mean(volume,4);
%extract indices from 4d nii
nii4d=make_nii(volume,nii4d.hdr.dime.pixdim(2:4),[0 0 0],nii4d.hdr.dime.datatype);
%save new 4d nii and save gradient table
[path,name,extension]=fileparts(filename);
namet='mDWI';
name_nii4d = [path '/' namet name extension];
save_nii(nii4d,name_nii4d);
res=numel(ind0)