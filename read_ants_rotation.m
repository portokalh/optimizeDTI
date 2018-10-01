function rotation=read_ants_rotation(input)

%argument check
[path name ext]=fileparts(input);
if ~strcmp(ext,'.mat')
    error('Please specify an ANTS *.mat affine as input');
end

load(input);

% get 3x3 matrix and extract rotation only
rotation=reshape(AffineTransform_double_3_3(1:9),3,3);
mag=sqrt(rotation(1,:).^2 + rotation(2,:).^2 + rotation(3,:).^2);
rotation=rotation./repmat(mag',1,3);