img='/Volumes/hellsblazes/Projects2/mouse_CHASS/N51200/dti/dti_S0.nii.gz';
dyad2='/Volumes/hellsblazes/Projects2/mouse_CHASS/N51200/bedpost/fsl.bedpostX/dyads2_thr0.05.nii.gz';
dyad3='/Volumes/hellsblazes/Projects2/mouse_CHASS/N51200/bedpost/fsl.bedpostX/dyads3_thr0.05.nii.gz';
dyad4='/Volumes/hellsblazes/Projects2/mouse_CHASS/N51200/bedpost/fsl.bedpostX/dyads4_thr0.05.nii.gz';

img=load_nii(img);
img.img(img.img>0)=1;

dyad2=load_nii(dyad2);
dyad2.img=sum(abs(dyad2.img),4);
dyad2.img(dyad2.img>0)=1;

dyad3=load_nii(dyad3);
dyad3.img=sum(abs(dyad3.img),4);
dyad3.img(dyad3.img>0)=1;

dyad4=load_nii(dyad4);
dyad4.img=sum(abs(dyad4.img),4);
dyad4.img(dyad4.img>0)=1;

alldyad=img.img+dyad2.img+dyad3.img+dyad4.img;

imagesc(alldyad(:,:,round(end/2))), axis image

nii=make_nii(alldyad,img.hdr.dime.pixdim(2:4),[0 0 0],2);
save_nii(nii,'/Users/edc15/Evan/Papers/in_progress/mouse_chass/figures/Extended_Figure_3/raw/fiber_count.nii.gz');

fract4=sum(dyad4.img(:))./sum(img.img(:));
fract3=sum(dyad3.img(:))./sum(img.img(:));
fract2=sum(dyad2.img(:))./sum(img.img(:));
fract1=sum(img.img(:))./sum(img.img(:));

pie4=fract4;
pie3=fract3-fract4;
pie2=fract2-fract3;
pie1=fract1-fract2;

figure(2)

x=[pie1, pie2, pie3, pie4];
sum(x)

h=pie(x,{'1','2','3','4'});

