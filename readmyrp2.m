%makephase

% console=2; %for agilent - runnos gt 50000
% console=1; %runnos ge - runnos lt 50000

%runnos={'N40800', 'N50922','N50930','N50929'};

young=1;%or 1 or 2
if young==1 %Agilent
runnos={'N50922','N50930','N50929','N50928','N50923','N50918','N50932','N50927','N50925','N50926','N50920'};%# 9 mo agilent scans
console=2;
else %GE
runnos={'N40804','N40800','N40803','N40802','N40801','N40809','N40808','N40805','N40806','N40807','N40782','N40790'};%12 mo GE scans
console=1;
end

niftipath='/Volumes/CivmUsers/omega/alx_mscripts/NIfTI_20140122/'
addpath(niftipath)
addpath('/Volumes/workstation_home/software/shared/civm_matlab_common_utils/');
voxsize=0.0352;

matlabpool local 6
parfor ind=1:numel(runnos)
runno=runnos{ind};



%show kspace 
%imshow(log(abs(raw_data(:,:,128))))
if console==1 %ge
    pathout='/Volumes/cretespace/jankowsky/alex_phase/12mo/';
    filerp=['/Volumes/cretespace/alex/jankowsky/luke/12mo/' runno '.work/' runno '.rp'];
    filep=ls(['/Volumes/cretespace/alex/jankowsky/luke/12mo/' runno '.work/'  'P*7']);
    filep=filep(1:end-1)
    [rp_hdr size_rp_hdr]=read_gehdr_local(filep);
    dims=[rp_hdr.image.dim_X rp_hdr.image.dim_Y rp_hdr.image.user10];
    fidfile=fopen(filerp,'r','l'); %opens a FID for the p-file
    fseek(fidfile,size_rp_hdr,'bof'); %skip the 66072 byte header
    raw_data=fread(fidfile,inf,'int32'); %read the raw data
    raw_data=reshape((1i*raw_data(1:2:end) + raw_data(2:2:end)),dims(1),dims(2),dims(3)); %reshape into complex array
    fclose('all');
    %imagesc(log(abs(raw_data(:,:,128))))
    %raw_data=imrotate(raw_data,180);
    %raw_data=flipdim(raw_data,3);
    raw_data=fftshift(ifftn(fftshift(raw_data)));
    
    
elseif console ==2 %agilent
    pathout='/Volumes/cretespace/jankowsky/alex_phase/9mo/';
    filerp=['/Volumes/cretespace/alex/jankowsky/luke/9mo/' runno '.work/' runno '.rp'];
    %filep=ls(['/Volumes/cretespace/alex/jankowsky/luke/9mo/' runno '.work/'  'P*7']);
    justdir=['/Volumes/cretespace/alex/jankowsky/luke/9mo/' runno '.work/']
    [dir,n,e]=fileparts(filerp);
    
    [npoints,nblocks,ntraces,bitdepth] = load_fid_hdr(filerp);
    %load_fid(fidpath,max_blocks,ntraces,npoints,bitdepth,cyclenum,voldims)
    [RE, IM, NP,NB,NT,HDR] = load_fid(justdir);
    
    
    dim = [NP NB NT]; %NB seems to be used already in load_fid, so volumes looks more appropriate., note NB was not the right thing to do when not a dti volume.
   
    
      
    RE=reshape(RE,dim);
    IM=reshape(IM,dim);
    raw_data=complex(RE(:,:,:),IM(:,:,:)); %reshape into complex array
    
          %fermi filter inlined for better memory useage.
%         raw_data=fermi_filter_isodim2_memfix(raw_data); %
raw_data=fftshift(ifftn(fftshift(raw_data))); %fftshift(ifftn(raw_data));
%     
    
%     img=abs(raw_data);
%     vals=unique(img);
%     numvals=numel(vals);
%     thresh=img(round(0.98*numvals));
%     img(img>thresh)=thresh;
%     imagesc(img(:,:,128))
    

end


fileout=[pathout runno 'phase.nii.gz'];
fileout2=[pathout runno 'magnitude.nii.gz'];
phase=single(angle(raw_data));
magnitude=single(abs(raw_data));

nii=make_nii(phase, [ voxsize voxsize voxsize] , [0 0 0]);
save_nii(nii, fileout)

nii2=make_nii(magnitude, [ voxsize voxsize voxsize] , [0 0 0]);
save_nii(nii2, fileout2)

% imagesc(log(abs(raw_data(:,:,128))))
% view_nii(nii);
% colormap(gray)

end

delete(gcp)

%to roll
% runno='N50923' %runno=;'N50928';
% miim=load_nii(['/Volumes/cretespace/jankowsky/alex_phase/9mo/' runno 'phase.nii.gz']);
% vol=miim.img;vol1=circshift(vol,25,2);
% mii1=miim;mii1.img=vol1;
% pathout='/Volumes/cretespace/jankowsky/alex_phase/9mo/'
% fileout=[pathout runno 'phase.nii.gz'];
% save_nii(mii1, fileout)
% 
% miim=load_nii(['/Volumes/cretespace/jankowsky/alex_phase/9mo/' runno 'magnitude.nii.gz']);
% vol=miim.img;vol1=circshift(vol,25,2);
% mii1=miim;mii1.img=vol1;
% pathout='/Volumes/cretespace/jankowsky/alex_phase/9mo/'
% fileout=[pathout runno 'magnitude.nii.gz'];
% save_nii(mii1, fileout)


