function corrected=diff_grad_correct(grad_vectors,affines)
%EDR12 file - grad vectors
%affines-cellarray to affine paths, which we get from tesnor pipeline

%argument check
if ~iscell(affines)
    error('Affines should be a cell array of strings');
end
if ~exist(grad_vectors,'file')
    error('Gradient vectors should be a file');
end


%% load grad_vectors
vectors=csvread(grad_vectors)';


%% registration correction

%perform gradient vector correction
for i=1:length(vectors)
    rotation=read_ants_rotation(affines{i});
    corrected_vecs(:,i)=rotation*vectors(:,i);
end

%% conversion to dsi studio format

%write corrected vectors
[path name ext]=fileparts(grad_vectors);
corrected=[path '/' name '_corrected.txt'];
dlmwrite(corrected,corrected_vecs','delimiter',',','precision',17)


