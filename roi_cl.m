niipath='/Volumes/TrinityDrive/N51200_v2/Brain_masks/Wholebrain_labels_BLA/segmentation_09162015smooth.nii.gz';

nii=load_nii(niipath);

[path name ext]=fileparts(niipath);

r=nii.img;
r(1:142,:,:)=0;

l=nii.img;
l(143:end,:,:)=0;


display('Right side')
for i=1:167;
    display(['number ' num2str(i)]);
    img=zeros(size(nii.img),'single');
    img(r==i)=1;
    out=make_nii(img,[22/512 22/512 22/512],[0 0 0],2);
    outpath=[path '/ROI_' sprintf('%03d',i) '_R.nii.gz'];
    save_nii(out,outpath);
end
display('Left side')
for i=1:167;
    display(['number ' num2str(i)]);
    img=zeros(size(nii.img),'single');
    img(l==i)=1;
    out=make_nii(img,[22/512 22/512 22/512],[0 0 0],2);
    outpath=[path '/ROI_' sprintf('%03d',i) '_L.nii.gz'];
    save_nii(out,outpath);
end