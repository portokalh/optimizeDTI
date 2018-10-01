%Load dyad files which should have nonzero values wherever there is a fiber
%calculated; make each voxel equal to one if non zero and then sum over the
%images to obtain an image which will have 1-4 fibers in every voxel;
img='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR120.bedpostX/dyads1.nii.gz';
dyad2='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR120.bedpostX/dyads2_thr0.05.nii.gz';
dyad3='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR120.bedpostX/dyads3_thr0.05.nii.gz';
dyad4='/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR120.bedpostX/dyads4_thr0.05.nii.gz';

img=load_nii(img);
img.img=sum(abs(img.img),4);
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

%change color map so that background is black and colors for pixel values
%of 1-4 correspond with Evan's paper;
map =[0 0 0
    0 0 1
    0 1 0
    1 1 0
    1 0 0] ;
colormap (map);    

imagesc(alldyad(:,:,round(30*end/54))), axis image

nii=make_nii(alldyad,img.hdr.dime.pixdim(2:4),[0 0 0],2);
save_nii(nii,'/Volumes/TrinityDrive/N51200_v2/bedpost/bedpost_fullbrain_ESR120.bedpostX/fiber_count.nii.gz');

%create pie chart showing proportion of voxels that contain 1,2,3 or 4
%fibers;

fract4=sum(dyad4.img(:))./sum(img.img(:));
fract3=sum(dyad3.img(:))./sum(img.img(:));
fract2=sum(dyad2.img(:))./sum(img.img(:));
fract1=sum(img.img(:))./sum(img.img(:));

pie4=fract4;
pie3=fract3-fract4;
pie2=fract2-fract3;
pie1=fract1-fract2;

pixels=sum(img.img(:));
totalfibers=pixels*((4*pie4)+(3*pie3)+(2*pie2)+(pie1));

figure(2)

x=[pie1 pie2 pie3 pie4];
labels = {'1 Fiber', '2 Fibers', '3 Fibers', '4 Fibers'};
h=pie(double (x), zeros (size(x)),labels);
