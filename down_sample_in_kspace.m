%function down_sample_in_kspace(in_nii,fermi_filter,w1,w2)
angles =  {'15' '20' '30' '60' '80' '100'}; %'80' '100'
%angles = {'120'};
for aa = 1:length(angles)
    angle = angles{aa};
    fermi_filter = 1;
    plot_me = 0;
    w1 = 0.15;
    w2 = 0.75;
    
    half_name = ['/nas4/rja20/Chass_data_resized/ESR' angle '_half_data.nii.gz'];
    quarter_name = ['/nas4/rja20/Chass_data_resized/ESR' angle '_quarter_data.nii.gz'];
    if ~exist(half_name,'file')
        
        %in_nii = ['/nas4/alex/ChrisLong/bedpost_ESR' angle '/data.nii'];
        in_nii = ['/glusterspace/BJs_incoming_data/bedpost_ESR' angle '/data_pad2.nii'];
        if ~exist(in_nii,'file')
            in_nii = [in_nii '.gz'];
        end
        work_nii = load_untouch_nii(in_nii);
        half_nii = work_nii;
        quarter_nii = work_nii;
        
        
        dims=work_nii.hdr.dime.dim;
        pixdims = work_nii.hdr.dime.pixdim;
        pixdims=pixdims(2:4);
        n_vols = dims(5);
        dims=dims(2:4);
        
        
        %dims = [284,460,214];
        
        half_dims = round(0.5*dims);
        half_nii.hdr.dime.dim(2:4)=half_dims;
        half_nii.img = zeros([half_dims]);
        
        quarter_dims = round(0.25*dims);
        quarter_nii.hdr.dime.dim(2:4)=quarter_dims;
        quarter_nii.img = zeros([quarter_dims]);
        
        half_pixdim = (dims.*pixdims)./(half_dims);
        half_nii.hdr.dime.pixdim(2:4)=half_pixdim;
        quarter_pixdim = (dims.*pixdims)./(quarter_dims);
        quarter_nii.hdr.dime.pixdim(2:4)=quarter_pixdim;
        
        half_starts=round(((1/2)-(1/4))*dims)+1;
        quarter_starts=round(((1/2)-(1/8))*dims)+1;
        
        half_ends = half_starts+half_dims-1;
        quarter_ends = quarter_starts+quarter_dims-1;
        
        %kspace = fftshift(fftn(fftshift(data_out)));
        complex_data = ones(dims);
        %w1=.1;
        %w2=.75;
        if exist('w1','var')
            complex_data = fermi_filter_isodim2_memfix(complex_data,w1,w2);
        else
            complex_data= fermi_filter_isodim2_memfix(complex_data);
        end
        %complex_data =fftshift(ifftn(fftshift(complex_data)));
        data_out = abs(complex_data);
        %             figure
        %             plot(data_out(:,:,128))
        
        inverse_fermi = 1./data_out;
        for vv = 1:n_vols
            original_image = complex(double(work_nii.img(:,:,:,vv)));
            kspace = fftshift(fftn(fftshift(original_image)));
            rawish_kspace = inverse_fermi.*kspace;
            
            half_data = rawish_kspace(half_starts(1):half_ends(1),half_starts(2):half_ends(2),half_starts(3):half_ends(3));
            quarter_data = rawish_kspace(quarter_starts(1):quarter_ends(1),quarter_starts(2):quarter_ends(2),quarter_starts(3):quarter_ends(3));
            
            if fermi_filter
                if exist('w1','var')
                    half_complex_data = fermi_filter_isodim2_memfix(half_data,w1,w2);
                    quarter_complex_data = fermi_filter_isodim2_memfix(quarter_data,w1,w2);
                else
                    half_complex_data= fermi_filter_isodim2_memfix(half_data);
                    quarter_complex_data= fermi_filter_isodim2_memfix(quarter_data);
                end
                half_complex_data =fftshift(ifftn(fftshift(half_complex_data)));
                quarter_complex_data =fftshift(ifftn(fftshift(quarter_complex_data)));
            else
                
                half_complex_data =fftshift(ifftn(fftshift(half_data)));
                quarter_complex_data =fftshift(ifftn(fftshift(quarter_data)));
            end
            half_data_out = abs(half_complex_data);
            quarter_data_out = abs(quarter_complex_data);
            
            half_nii.img(:,:,:,vv) = half_data_out;
            quarter_nii.img(:,:,:,vv) = quarter_data_out;
            
            %rawish_complex=fftshift(ifftn(fftshift(rawish_kspace)));
            
            %rawish_image = abs(rawish_complex);
            if plot_me
                
                figure(4)
                %plot(down_data(:,:,64))
                imagesc(original_image(:,:,round(dims(3)/2)))
                figure(5)
                %plot(down_data(:,:,64))
                imagesc(half_data_out(:,:,round(half_dims(3)/2)))
                figure(6)
                %plot(down_data(:,:,64))
                imagesc(quarter_data_out(:,:,round(quarter_dims(3)/2)))
                
                pause(3)
            end
        end
        
        
        for dd = 1:2
            if (dd == 1)
                data0 = half_nii.img;
            else
                data0 = quarter_nii.img;
            end
            
            thresh = .999999999; % only clip out very noisy voxels (e.g. zippers, artifacts), and not the eyes
            
            q = quantile(abs(data0(:)),thresh);
            %scaling = (2^16-1)/q; % (From CS recon code) we plan on writing out uint16 not int16, though it won't show up well in the database
            scaling = (2^15-1)/q;
            if (dd == 1)
                half_nii.img = scaling*half_nii.img;
            else
                quarter_nii.img = scaling*quarter_nii.img;
            end
        end
        
        half_name = ['/nas4/rja20/Chass_data_resized/ESR' angle '_half_data.nii.gz'];
        quarter_name = ['/nas4/rja20/Chass_data_resized/ESR' angle '_quarter_data.nii.gz'];
        
        %test_name = ['/nas4/rja20/Chass_data_resized/ESR' angle '_half_data_test.nii.gz'];
        %test_nii =  half_nii;
        %test_nii.img = permute(half_nii.img,[4 1 2 3]);
        %test_nii.hdr.dime.dim(2:5)=[half_nii.hdr.dime.dim(5) half_nii.hdr.dime.dim(2:4)];
        %test_nii.hdr.dime.pixdim(2:5)=[half_nii.hdr.dime.pixdim(5) half_nii.hdr.dime.pixdim(2:4)];
        
        if ~exist(half_name,'file')
            save_untouch_nii(half_nii,half_name);
        end
        
        
        %if ~exist(test_name,'file')
        %    save_untouch_nii(test_nii,test_name);
        %end
        
        if ~exist(quarter_name,'file')
            save_untouch_nii(quarter_nii,quarter_name);
        end
        
    end
end