a=importdata('/Volumes/TrinityDrive/N51200/Figures/DSI_Studio/Matlab_connect/ESR120_connect.mat')
b=importdata('/Volumes/TrinityDrive/N51200/Figures/DSI_Studio/Matlab_connect/ESR100_connect.mat')

connectivity=abs(a-b)
connectivitylog=log10(connectivity)

figure (1)
colormap (jet);
clims = [0 1500]
imagesc (connectivity, clims)
colorbar

figure (2)
colormap (jet);
clims = [0 4]
imagesc (connectivitylog, clims)
colorbar

