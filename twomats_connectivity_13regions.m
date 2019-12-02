function [rho,pval]=twomats_connectivity_13regions(MAverageIso,MAverage12mm)
[rho,pval]=corr((reshape(MAverageIso,1,169)'),(reshape(MAverage12mm,1,169)'),'type','Spearman');
k=1
myind=[0 0]

for i=1:12
    for j=i+1:13
        k=k+1
        myind=[myind;  i j];
m1(k)=MAverageIso(i,j);
m2(k)=MAverage12mm(i,j);
    end
end

[rho,pval]=corr(m1',m2','type','Spearman');

ind0=find(m1.*m2~=0);
m11=m1(ind0);
m22=m2(ind0);

[rho,pval]=corr(m11',m22','type','Spearman');
