function TDI(input_trk,voxsize)
% load the track file into memory
display('loading track file...')
tic
tracks=load_track(input_trk);
display('done loading track file')
toc

% calculate new array size
array_size_x=(tracks.dim(1,1)*tracks.resol(1,1))/voxsize;
array_size_y=(tracks.dim(2,1)*tracks.resol(2,1))/voxsize;
array_size_z=(tracks.dim(3,1)*tracks.resol(3,1))/voxsize;

% create new array as uint16
tdi_img=uint16(zeros(array_size_x,array_size_y,array_size_z));

% write track density info
display('writing tracks to TDI...')
tic
for n=1:size(tracks.track,2)
    for nn=1:(size(tracks.track{1,n})-1)
        vect=tracks.track{1,n}((nn+1),:)-tracks.track{1,n}(nn,:);
        nvect=norm(vect);
        vect=vect/nvect;
        for k=0:voxsize:nvect
            point=tracks.track{1,n}(nn,:)+k*vect;
            point=point/voxsize;
            point=round(point); % rounding may put points outside of array
            tdi_img(point(1),point(2),point(3))=(tdi_img(point(1),point(2),point(3))+1);
        end
    end
end
display('done writing tracks to TDI')
toc

% make the tdi a nii
display('making nii...')
tic
tdi_nii=make_nii(tdi_img, [voxsize voxsize voxsize], [0 0 0], 512);
display('done making nii')

% generate the save path
[path filename extension]=fileparts(input_trk);
outfile=strcat(filename,'_tdi','.nii');

% save the tdi image
display('saving TDI as nii');
tic
save_nii(tdi_nii,fullfile(path,outfile));
display('saved TDI to disk as nii');
toc