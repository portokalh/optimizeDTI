% conmat_1x_12.csv	conmat_2x_12.csv	conmat_4x_12.csv
% conmat_1x_120.csv	conmat_2x_120.csv	conmat_4x_120.csv
% conmat_1x_45.csv	conmat_2x_45.csv	conmat_4x_45.csv
blabels={'Cg' 'Ins' 'TeA' 'Ent' 'Hc' 'Hyp' 'LPO' 'Spt' 'LGN' 'fi' 'fx' 'mt' 'LD'};
climax=0.5;

mypath='/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/csvsheets/conmats0/';
conmat_1x_12=csvread([mypath,'conmat_1x_12.csv'], 1,1,[ 1 1 13 13]);
conmat_1x_45=csvread([mypath,'conmat_1x_45.csv'], 1,1,[ 1 1 13 13]);
conmat_1x_120=csvread([mypath,'conmat_1x_120.csv'], 1,1,[ 1 1 13 13]);
conmat_2x_12=csvread([mypath,'conmat_2x_12.csv'], 1,1,[ 1 1 13 13]);
conmat_2x_45=csvread([mypath,'conmat_2x_45.csv'], 1,1,[ 1 1 13 13]);
conmat_2x_120=csvread([mypath,'conmat_2x_120.csv'], 1,1,[ 1 1 13 13]);
conmat_4x_12=csvread([mypath,'conmat_4x_12.csv'], 1,1,[ 1 1 13 13]);
conmat_4x_45=csvread([mypath,'conmat_4x_45.csv'], 1,1,[ 1 1 13 13]);
conmat_4x_120=csvread([mypath,'conmat_4x_120.csv'], 1,1,[ 1 1 13 13]);

r1=conmat_1x_12;
r2=conmat_1x_45;
r3=conmat_1x_120;
r4=conmat_2x_12;
r5=conmat_2x_45;
r6=conmat_2x_120;
r7=conmat_4x_12;
r8=conmat_4x_45;
r9=conmat_4x_120;

S1_12_45=graph_similarity(conmat_1x_12,conmat_1x_45);
S1_45_120=graph_similarity(conmat_1x_45,conmat_1x_120);
S1_12_120=graph_similarity(conmat_1x_12,conmat_1x_120);

S1_S2_12_12=graph_similarity(conmat_1x_12,conmat_2x_12);
S1_S2_45_45=graph_similarity(conmat_1x_45,conmat_2x_45);
S1_S2_120_120=graph_similarity(conmat_1x_120,conmat_2x_120);

S1_S4_12_12=graph_similarity(conmat_1x_12,conmat_4x_12);
S1_S4_45_45=graph_similarity(conmat_1x_45,conmat_4x_45);
S1_S4_120_120=graph_similarity(conmat_1x_120,conmat_4x_120);

S2_S4_12_12=graph_similarity(conmat_2x_12,conmat_4x_12);
S2_S4_45_45=graph_similarity(conmat_2x_45,conmat_4x_45);
S2_S4_120_120=graph_similarity(conmat_2x_120,conmat_4x_120);


clims = [0 0.7];
clims = [-10 0];
clims = [-5 0];
mycolors=jet(200)
n=1
mycolors(1:n,:)=ones(n,1)*[1,1,1]

myclim=[0.01, 0.8*max([max(S1_12_120(:)), max(S1_45_120(:)),max(S1_12_45(:))])]
clims=myclim
figure(1)

subplot(3,3,1);
myclim=[0.01, 0.8*max([max(S1_12_45(:)), max(S1_12_45(:)),max(S1_12_45(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_12_45),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title(['Subplot 1: S1 12 45: ' num2str(median(S1_12_45(:)))])
res=gca();
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;

subplot(3,3,2);
myclim=[0.01, 0.8*max([max(S1_45_120(:)), max(S1_45_120(:)),max(S1_45_120(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_45_120),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title('Subplot 2: S1 45 120')
title(['Subplot 2: S1 45 120: ' num2str(median(S1_45_120(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;

subplot(3,3,3);
myclim=[0.01, 0.8*max([max(S1_12_120(:)), max(S1_12_120(:)),max(S1_12_120(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_12_120),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title('Subplot 3: S1 12 120')
title(['Subplot 3: S1 12 120: ' num2str(median(S1_12_120(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;

subplot(3,3,4);
myclim=[0.01, 0.8*max([max(S1_S2_12_12(:)), max(S1_S2_12_12(:)),max(S1_S2_12_12(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_S2_12_12),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title(['Subplot 4: S1 S2 12 12', median(S1_S2_12_12)])
title(['Subplot 4: S1 S2 12 12: ' num2str(median(S1_S2_12_12(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;


subplot(3,3,5);
myclim=[0.01, 0.8*max([max(S1_S2_45_45(:)), max(S1_S2_45_45(:)),max(S1_S2_45_45(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_S2_45_45),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title('Subplot 5: S1 S2 45 45')
title(['Subplot 5: S1 S2 45 45: ' num2str(median(S1_S2_45_45(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;

subplot(3,3,6);
myclim=[0.01, 0.8*max([max(S1_S2_120_120(:)), max(S1_S2_120_120(:)),max(S1_S2_120_120(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_S2_120_120),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title('Subplot 6: S1 S2 120 120')
title(['Subplot 6: S1 S2 120 120: ' num2str(median(S1_S2_120_120(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;

subplot(3,3,7);
myclim=[0.01, 0.8*max([max(S1_S4_12_12(:)), max(S1_S4_12_12(:)),max(S1_S4_12_12(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_S4_12_12),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title(['Subplot 7: S1 S4 12 12: ' num2str(median(S1_S4_12_12(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;


subplot(3,3,8);
myclim=[0.01, 0.8*max([max(S1_S4_45_45(:)), max(S1_S4_45_45(:)),max(S1_S4_45_45(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_S4_45_45),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title('Subplot 8: S1 S4 45 45')
title(['Subplot 8: S1 S4 45 45: ' num2str(median(S1_S4_45_45(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;

subplot(3,3,9);
myclim=[0.01, 0.8*max([max(S1_S4_120_120(:)), max(S1_S4_120_120(:)),max(S1_S4_120_120(:))])]
clims=myclim
clims=[0.01 climax]
imagesc((S1_S4_120_120),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
title('Subplot 9: S1 S4 120 120')
title(['Subplot 9: S1 S4 120 120: ' num2str(median(S1_S4_120_120(:)))])
res=gca();
res.XTick=1:numel(blabels);
res.YTick=1:numel(blabels);
res.XTickLabel=blabels;
res.YTickLabel=blabels;
res.XTickLabelRotation=90;

print('/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/graphsimilarity3_max0p5.png', '-dpng', '-r300');


allrhos=zeros(9,9);

[a,b]=twomats_connectivity_13regions(r1,r1);
allrhos(1,1)=a;
[a,b]=twomats_connectivity_13regions(r1,r2);
allrhos(1,2)=a;
[a,b]=twomats_connectivity_13regions(r1,r3);
allrhos(1,3)=a;
[a,b]=twomats_connectivity_13regions(r1,r4);
allrhos(1,4)=a;
[a,b]=twomats_connectivity_13regions(r1,r5);
allrhos(1,5)=a;
[a,b]=twomats_connectivity_13regions(r1,r6);
allrhos(1,6)=a;
[a,b]=twomats_connectivity_13regions(r1,r7);
allrhos(1,7)=a;
[a,b]=twomats_connectivity_13regions(r1,r8);
allrhos(1,8)=a;
[a,b]=twomats_connectivity_13regions(r1,r9);
allrhos(1,9)=a;

[a,b]=twomats_connectivity_13regions(r2,r1);
allrhos(2,1)=a;
[a,b]=twomats_connectivity_13regions(r2,r2);
allrhos(2,2)=a;
[a,b]=twomats_connectivity_13regions(r2,r3);
allrhos(2,3)=a;
[a,b]=twomats_connectivity_13regions(r2,r4);
allrhos(2,4)=a;
[a,b]=twomats_connectivity_13regions(r2,r5);
allrhos(2,5)=a;
[a,b]=twomats_connectivity_13regions(r2,r6);
allrhos(2,6)=a;
[a,b]=twomats_connectivity_13regions(r2,r7);
allrhos(2,7)=a;
[a,b]=twomats_connectivity_13regions(r2,r8);
allrhos(2,8)=a;
[a,b]=twomats_connectivity_13regions(r2,r9);
allrhos(2,9)=a;

[allrhos(3,1),b]=twomats_connectivity_13regions(r3,r1);
[allrhos(3,2),b]=twomats_connectivity_13regions(r3,r2);
[allrhos(3,3),b]=twomats_connectivity_13regions(r3,r3);
[allrhos(3,4),b]=twomats_connectivity_13regions(r3,r4);
[allrhos(3,5),b]=twomats_connectivity_13regions(r3,r5);
[allrhos(3,6),b]=twomats_connectivity_13regions(r3,r6);
[allrhos(3,7),b]=twomats_connectivity_13regions(r3,r7);
[allrhos(3,8),b]=twomats_connectivity_13regions(r3,r8);
[allrhos(3,9),b]=twomats_connectivity_13regions(r3,r9);

[allrhos(4,1),b]=twomats_connectivity_13regions(r4,r1);
[allrhos(4,2),b]=twomats_connectivity_13regions(r4,r2);
[allrhos(4,3),b]=twomats_connectivity_13regions(r4,r3);
[allrhos(4,4),b]=twomats_connectivity_13regions(r4,r4);
[allrhos(4,5),b]=twomats_connectivity_13regions(r4,r5);
[allrhos(4,6),b]=twomats_connectivity_13regions(r4,r6);
[allrhos(4,7),b]=twomats_connectivity_13regions(r4,r7);
[allrhos(4,8),b]=twomats_connectivity_13regions(r4,r8);
[allrhos(4,9),b]=twomats_connectivity_13regions(r4,r9);

[allrhos(5,1),b]=twomats_connectivity_13regions(r5,r1);
[allrhos(5,2),b]=twomats_connectivity_13regions(r5,r2);
[allrhos(5,3),b]=twomats_connectivity_13regions(r5,r3);
[allrhos(5,4),b]=twomats_connectivity_13regions(r5,r4);
[allrhos(5,5),b]=twomats_connectivity_13regions(r5,r5);
[allrhos(5,6),b]=twomats_connectivity_13regions(r5,r6);
[allrhos(5,7),b]=twomats_connectivity_13regions(r5,r7);
[allrhos(5,8),b]=twomats_connectivity_13regions(r5,r8);
[allrhos(5,9),b]=twomats_connectivity_13regions(r5,r9);

[allrhos(6,1),b]=twomats_connectivity_13regions(r6,r1);
[allrhos(6,2),b]=twomats_connectivity_13regions(r6,r2);
[allrhos(6,3),b]=twomats_connectivity_13regions(r6,r3);
[allrhos(6,4),b]=twomats_connectivity_13regions(r6,r4);
[allrhos(6,5),b]=twomats_connectivity_13regions(r6,r5);
[allrhos(6,6),b]=twomats_connectivity_13regions(r6,r6);
[allrhos(6,7),b]=twomats_connectivity_13regions(r6,r7);
[allrhos(6,8),b]=twomats_connectivity_13regions(r6,r8);
[allrhos(6,9),b]=twomats_connectivity_13regions(r6,r9);

[allrhos(7,1),b]=twomats_connectivity_13regions(r7,r1);
[allrhos(7,2),b]=twomats_connectivity_13regions(r7,r2);
[allrhos(7,3),b]=twomats_connectivity_13regions(r7,r3);
[allrhos(7,4),b]=twomats_connectivity_13regions(r7,r4);
[allrhos(7,5),b]=twomats_connectivity_13regions(r7,r5);
[allrhos(7,6),b]=twomats_connectivity_13regions(r7,r6);
[allrhos(7,7),b]=twomats_connectivity_13regions(r7,r7);
[allrhos(7,8),b]=twomats_connectivity_13regions(r7,r8);
[allrhos(7,9),b]=twomats_connectivity_13regions(r7,r9);

[allrhos(8,1),b]=twomats_connectivity_13regions(r8,r1);
[allrhos(8,2),b]=twomats_connectivity_13regions(r8,r2);
[allrhos(8,3),b]=twomats_connectivity_13regions(r8,r3);
[allrhos(8,4),b]=twomats_connectivity_13regions(r8,r4);
[allrhos(8,5),b]=twomats_connectivity_13regions(r8,r5);
[allrhos(8,6),b]=twomats_connectivity_13regions(r8,r6);
[allrhos(8,7),b]=twomats_connectivity_13regions(r8,r7);
[allrhos(8,8),b]=twomats_connectivity_13regions(r8,r8);
[allrhos(8,9),b]=twomats_connectivity_13regions(r8,r9);

[allrhos(9,1),b]=twomats_connectivity_13regions(r9,r1);
[allrhos(9,2),b]=twomats_connectivity_13regions(r9,r2);
[allrhos(9,3),b]=twomats_connectivity_13regions(r9,r3);
[allrhos(9,4),b]=twomats_connectivity_13regions(r9,r4);
[allrhos(9,5),b]=twomats_connectivity_13regions(r9,r5);
[allrhos(9,6),b]=twomats_connectivity_13regions(r9,r6);
[allrhos(9,7),b]=twomats_connectivity_13regions(r9,r7);
[allrhos(9,8),b]=twomats_connectivity_13regions(r9,r8);
[allrhos(9,9),b]=twomats_connectivity_13regions(r9,r9);

figure(2)
clims=[0.5 1]
for i=1:9 
    allrhos(i,i)=0 ;
end
imagesc((allrhos),clims); colormap(mycolors);colorbar; set(gcf,'color','w');
xticklabels({'conmat 1x 12' ,'conmat 1x 45', 'conmat 1x 120','conmat 2x 12', 'conmat 2x 45', 'conmat 2x 120', 'conmat 4x 12', 'conmat 4x 45', 'conmat 4x 120'});
yticklabels({'conmat 1x 12' ,'conmat 1x 45', 'conmat 1x 120','conmat 2x 12', 'conmat 2x 45', 'conmat 2x 120', 'conmat 4x 12', 'conmat 4x 45', 'conmat 4x 120'});
xtickangle(90)
print('/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/allcorrssimilarity0.png', '-dpng', '-r300');

labels={'conmat 1x 12' ,'conmat 1x 45', 'conmat 1x 120','conmat 2x 12', 'conmat 2x 45', 'conmat 2x 120', 'conmat 4x 12', 'conmat 4x 45', 'conmat 4x 120'}
X=allrhos
Z = linkage(X,'ward');
c = cluster(Z,'Maxclust',4);
tree = linkage(X,'average','chebychev');
D = pdist(X);
leafOrder_git = optimalleaforder(tree,D)
[cgit,pgit]=corr(volgit');
indgit=find(abs(cgit)<0.5);
leafOrder_git=[1 4 7 2 5 8 3 6 9]
imagesc(X(leafOrder_git,leafOrder_git), [0.5,0.8])
imagesc(X(leafOrder_git,leafOrder_git),[0.5,0.95]); colormap(mycolors);colorbar; set(gcf,'color','w');
res=gca()
res.XTick=1:35
res.YTick=1:35
res.XTickLabel=labels(leafOrder_git)
res.YTickLabel=labels(leafOrder_git)
res.XTickLabelRotation=90
%set(get(gca,'XLabel'),'Rotation',90)
%colormap(mycmap)
set(gcf,'color','w');
title("Subgraph Similarity")
colorbar

print('/Users/alex/AlexBadea_MyPapers/ChrisLong/DiffusionPaper/allcorrssimilarity3.png', '-dpng', '-r300');
