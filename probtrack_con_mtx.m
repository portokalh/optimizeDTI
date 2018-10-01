function probtrack_con_mtx(out_dir,ROI_dir,tract_dir)

%% DOCUMENTATION

% This script takes as inputs a folder containing multiple seed ROIs used
% for probabilistic tractography and a second folder containing the
% probabilistic tractography datasets generated from those seed ROIs. The
% output is a nxn weighted connectivity matrix. Connection strengths (i.e.
% edge weights) are normalized by the total volume of the seed region used
% to generate the data to account for differences in the number of total
% tractography seeds.

% INPUTS
% out_dir - a directory to save the output connectivity matrix
% ROI_dir - a directory containing n NIfTI format ROI files used for tractography
% tract_dir - a directory containing n NIfTI format probabilistic tractography files generated from the ROIs in ROI_dir

% OUTPUTS
% out_dir/con_mtx.mat - an nxn, directed, weighted connectivity matrix, corrected for total seed volume

% REQUIREMENTS
% NIfTI MATLAB toolkit: http://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image

%% get output directory and listings for ROIs and tractography files

% output
if ~exist('out_dir','var')
    display('select output folder')
    out_dir=uigetdir(pwd,'select output folder');
end

% ROI files
if ~exist('ROI_dir','var')
    display('select roi folder')
    ROI_dir=uigetdir(pwd,'select ROI folder');
end
roi_list=dir(fullfile(ROI_dir,'*.nii*'));


% Tractography files
if ~exist('tract_dir','var')
    display('select tractography folder')
    tract_dir=uigetdir(pwd,'select tractography folder');
end
tract_list=dir(fullfile(tract_dir,'*.nii*'));

%% load ROIs and get their logical indices

% preallocate output variables for ROI indicies and total volume
roi_inds=cell(size(roi_list));
roi_size=zeros(1,length(roi_list),'single');

% verbosity
display('Loading ROIs');

% load each ROI in a loop and get array indices and total size
for i=1:length(roi_list)
    display(['Loading ROI ' num2str(i) ' of ' num2str(length(roi_list))]);
    nii=load_nii(fullfile(ROI_dir,roi_list(i).name));
    roi_size(i)=numel(nii.img(nii.img==1));
    roi_inds{i}=logical(nii.img);
end

%% load each tractography file and calculate total connectivity to each ROI

% preallocate nxn connectivity matrix output and scale factor list
con_mtx=zeros(length(tract_list),length(tract_list));
scale_factor=zeros(size(tract_list));

% verbosity
display('Loading tractography');

% connectivity for loop
for i=1:length(tract_list)
    
    % verbosity
    display(['Loading tractography ' num2str(i) ' of ' num2str(length(roi_list))]);
    
    nii=load_nii(fullfile(tract_dir,tract_list(i).name));
    tracts=nii.img;
    
    % calculate scale factor to correct for seed ROI size
    scale_factor(i)=max(roi_size)./roi_size(i);
    
    % nested loop for calculating connectivity to each ROI
    for z=1:length(roi_list)
        
        % verbostiy
        display(['Matrix coordinate (' num2str(i) ',' num2str(z) ') of (' num2str(length(roi_list)) ',' num2str(length(tract_list)) ')']);
        
        % edge weight = total number of tracts inside each ROI
        con_mtx(i,z)=sum(tracts(roi_inds{z}));
    end
end

% apply scale factor to the resultant connectivity matrix
scale_factor=repmat(scale_factor,1,length(scale_factor)); % make nxn scale factor array
scale_factor(scale_factor==Inf)=0; % avoid divid by zero error
con_mtx=con_mtx.*scale_factor; % element-wise multiplication

%% save output data
output=fullfile(out_dir,'con_mtx.mat');
n=1;

% prevent overwrite
while exist(output,'file')
    output=fullfile(out_dir,['con_mtx' num2str(n) '.mat']);
    n=n+1;
end

% save .mat file
save(output,'con_mtx');
display(['Saved output to ' output]);