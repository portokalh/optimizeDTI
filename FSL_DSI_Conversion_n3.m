% Code will convert FSL BEDPOSTX data into DSISTUDIO .fib file; 

theta1 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_th1samples.nii.gz');
theta2 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_th2samples.nii.gz');
theta3 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_th3samples.nii.gz');
phi1 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_ph1samples.nii.gz');
phi2 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_ph2samples.nii.gz');
phi3 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_ph3samples.nii.gz');
f1 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_f1samples.nii.gz');
f2 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_f2samples.nii.gz');
f3 = load_untouch_nii('/Volumes/TrinityDrive/N51200/bedpost/bedpost_fullbrain_ESR12/mean_f3samples.nii.gz');
fib.dimension = size(f1.img);
fib.voxel_size = f1.hdr.dime.pixdim(2:4);
fib.fa0 = double(reshape(f1.img,1,[]));
fib.fa1 = double(reshape(f2.img,1,[]));
fib.fa2 = double(reshape(f3.img,1,[]));
fib.dir0(1,:,:,:) = sin(theta1.img).*cos(phi1.img);
fib.dir0(2,:,:,:) = sin(theta1.img).*sin(phi1.img);
fib.dir0(3,:,:,:) = cos(theta1.img);
fib.dir1(1,:,:,:) = sin(theta2.img).*cos(phi2.img);
fib.dir1(2,:,:,:) = sin(theta2.img).*sin(phi2.img);
fib.dir1(3,:,:,:) = cos(theta2.img);
fib.dir2(1,:,:,:) = sin(theta3.img).*cos(phi3.img);
fib.dir2(2,:,:,:) = sin(theta3.img).*sin(phi3.img);
fib.dir2(3,:,:,:) = cos(theta3.img);
fib.dir0 = double(reshape(fib.dir0,3,[]));
fib.dir1 = double(reshape(fib.dir1,3,[]));
fib.dir2 = double(reshape(fib.dir2,3,[]));

% flip xy: you may need to make sure that this orientation is correct

fib.fa0 = reshape(fib.fa0,fib.dimension);
fib.fa0 = fib.fa0(fib.dimension(1):-1:1,fib.dimension(2):-1:1,:);
fib.fa0 = reshape(fib.fa0,1,[]);

fib.fa1 = reshape(fib.fa1,fib.dimension);
fib.fa1 = fib.fa1(fib.dimension(1):-1:1,fib.dimension(2):-1:1,:);
fib.fa1 = reshape(fib.fa1,1,[]);

fib.fa2 = reshape(fib.fa2,fib.dimension);
fib.fa2 = fib.fa2(fib.dimension(1):-1:1,fib.dimension(2):-1:1,:);
fib.fa2 = reshape(fib.fa2,1,[]);


fib.dir0 = reshape(fib.dir0,[3 fib.dimension]);
fib.dir0 = fib.dir0(:,fib.dimension(1):-1:1,fib.dimension(2):-1:1,:);
fib.dir0(3,:,:,:) = -fib.dir0(3,:,:,:);
fib.dir0 = reshape(fib.dir0,3,[]);

fib.dir1 = reshape(fib.dir1,[3 fib.dimension]);
fib.dir1 = fib.dir1(:,fib.dimension(1):-1:1,fib.dimension(2):-1:1,:);
fib.dir1(3,:,:,:) = -fib.dir1(3,:,:,:);
fib.dir1 = reshape(fib.dir1,3,[]);

fib.dir2 = reshape(fib.dir2,[3 fib.dimension]);
fib.dir2 = fib.dir2(:,fib.dimension(1):-1:1,fib.dimension(2):-1:1,:);
fib.dir2(3,:,:,:) = -fib.dir2(3,:,:,:);
fib.dir2 = reshape(fib.dir2,3,[]);

save('out.fib', '-struct','fib','-v4');