a=importdata('/Volumes/TrinityDrive/N51200_v2/connectivity/ESR120/Output/con_mtx.mat');
b=log10(a);

figure (1)
colormap (jet);
clims = [0 10000000000]
imagesc (a, clims)
colorbar

figure (2)
colormap (jet);
clims = [0 13]
imagesc (b, clims)
colorbar