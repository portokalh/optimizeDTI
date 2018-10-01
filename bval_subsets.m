%function bval_subsets(higher_order_csv,subset_num)

higher_order_csv='/Users/edc15/Evan/Downloads/HARDI_tables/mgh_30.csv';

subset_num=18;


high=csvread(higher_order_csv);

display('Computing combos');
combos=combntns(1:length(high),subset_num);

dist_vect=zeros(length(combos),1);

display('Computing distances');
for i=1:length(combos)
    dist_vect(i,1)=sum(sum(pdist(high(combos(i,:),:))));
end

[max best_subset_ind]=max(dist_vect);

output=high(combos(best_subset_ind,:),:);

[path1 name1 ext1]=fileparts(higher_order_csv);

outpath=[path1 '/' num2str(subset_num) '_from_' name1 ext1];

csvwrite(outpath,output);