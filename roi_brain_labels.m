niipath='/Volumes/TrinityDrive/N51200_v2/Brain_masks/Wholebrain_labels_BLA/segmentation_09162015smooth.nii.gz';

%Load nii untouched so that RAS formatting remains intact; tried to just
%load_nii and masks were flipped
nii=load_untouch_nii(niipath);

[path name ext]=fileparts(niipath);

%Divide brain into left and right by taking pixels to right of midline
r=nii.img;
r(1:142,:,:)=0;

l=nii.img;
l(143:end,:,:)=0;

%step through each label starting at 1 and going through the 166 labels in
%this file
display('Right side')
for i=1:167;
    display(['number ' num2str(i)]);
    current=nii;
    current.img=zeros(size(nii.img),'single');
    current.img(r==i)=1;
    out=make_nii(current.img,[22/512 22/512 22/512],[0 0 0],2);
    outpath=[path '/ROI_' sprintf('%03d',i) '_R.nii.gz'];
    save_nii(out,outpath);
end
display('Left side')
for i=1:167;
    display(['number ' num2str(i)]);
    current=nii;
    current.img=zeros(size(nii.img),'single');
    current.img(l==i)=1;
    out=make_nii(current.img,[22/512 22/512 22/512],[0 0 0],2);
    outpath=[path '/ROI_' sprintf('%03d',i) '_L.nii.gz'];
    save_nii(out,outpath);
end