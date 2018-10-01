function roi_from_seg(input,label_values,label_name)
orig=load_nii(input);
label=orig.img;
clear orig

for n=1:length(label_values);
    display(horzcat('Adding label number ',num2str(n),' of ',num2str(length(label_values))));
    label(label==label_values(n))=max(label_values);
end

display('Setting other labels to 0');
label(label~=max(label_values))=0;

display('Setting ROI label to 1');
label(label==max(label_values))=1;

display('Making NIfTI');
labelnii=make_nii(label,[0.05 0.05 0.05],[0 0 0],2);
[path name ext]=fileparts(input);
outpath=fullfile(path,strcat(name,'_',label_name,ext));

display('Saving NIfTI');
save_nii(labelnii,outpath);

display('Formatting ROI for TrackVis');
make_trackvis_ROI(outpath);

display('Removing intermediate...');
system(horzcat('rm ',outpath)); %this removes the intermediate non-trackvis 8-bit mask

display('Done!');