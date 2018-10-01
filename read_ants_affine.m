function rotation=read_ants_affine(input)

%argument check
[path name ext]=fileparts(input);
if ~strcmp(ext,'.txt')
    error('Please specify an ANTS text file affine as input');
end

fid=fopen(input);

affine_txt=textscan(fid,'%s');
rotation=reshape(str2double(affine_txt{1,1}(10:18)),3,3);