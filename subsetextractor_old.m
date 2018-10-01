function volume=subsetextractor(path,majorgradienttable,inputtable)
%functionsubsetextractor (path,majorgradienttable,inputtable), path is a path to a 4d nii, input table is a
%subset of major table

%load 4d nii
%run vector finder
%extract indices from 4d nii
%save new 4d nii and save gradient table
nii4d=load_nii(path);
[table,indices]=DTI_gradient_subselector(inputtable,majorgradienttable);
volume=nii4d.img(:,:,:,indices);
nii4d.img=volume;
[path,name,extension]=fileparts(path);
[patht,namet,extensiont]=fileparts(inputtable);
save_nii(nii4d,[path '/' name '_' namet extension]);