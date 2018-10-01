%Load dyad files which should have nonzero values wherever there is a fiber
%calculated; make each voxel equal to one if non zero and then sum over the
%images to obtain an image which will have 1-4 fibers in every voxel;
addpath('/Volumes/TrinityDrive/N51200_v2/NIfTI_20140122')
addpath('/Volumes/TrinityDrive/N51200_v2/altmany-export_fig-f13ef82')
angles = {'12' '15' '20' '30' '45' '60' '80' '100' '120'};
resolutions = {'_2x' '_4x'};
for rr = 1:length(resolutions)
for aa = 1:length(angles)
    angle=angles{aa};
    res=resolutions{rr};
    main_prefix=['/Volumes/TrinityDrive/N51200_v2/kspace_downsampled_resolution/chass_downsampled' res '/bedpost_ESR'];
    img=[main_prefix angle res '.bedpostX/dyads1.nii.gz'];
    dyad2=[main_prefix angle res '.bedpostX/dyads2_thr0.05.nii.gz'];
    dyad3=[main_prefix angle res '.bedpostX/dyads3_thr0.05.nii.gz'];
    dyad4=[main_prefix angle res '.bedpostX/dyads4_thr0.05.nii.gz'];
    out_nii=[main_prefix angle res '/ESR' angle res '_fiber_count.nii.gz'];
    out_slice=[main_prefix angle res '/ESR' angle res '_fiber_count_midslize.fig'];
    out_slice_png=[main_prefix angle res '/ESR' angle res '_fiber_count_midslize.png'];
    out_pie=[main_prefix angle res '/ESR' angle res '_fiber_count_piechart.fig'];
    out_pie_png=[main_prefix angle res '/ESR' angle res '_fiber_count_piechart.png'];
    
    img=load_nii(img);
    img.img=sum(abs(img.img),4);
    img.img(img.img>0)=1;
    
    dyad2=load_nii(dyad2);
    dyad2.img=sum(abs(dyad2.img),4);
    dyad2.img(dyad2.img>0)=1;
    
    dyad3=load_nii(dyad3);
    dyad3.img=sum(abs(dyad3.img),4);
    dyad3.img(dyad3.img>0)=1;
    
    dyad4=load_nii(dyad4);
    dyad4.img=sum(abs(dyad4.img),4);
    dyad4.img(dyad4.img>0)=1;
    
    alldyad=img.img+dyad2.img+dyad3.img+dyad4.img;
    
    %change color map so that background is black and colors for pixel values
    %of 1-4 correspond with Evan's paper;
    
    if (str2num(angle) <= 45)
    map =[0 0 0
        0 0 1
        0 1 0
        1 1 0];
    else
    map =[0 0 0
        0 0 1
        0 1 0
        1 1 0
        1 0 0];
    end
    hh = figure(str2num(angle));
    set(hh,'Color','w')
    colormap (map);
    
    midslice=[60 30];
    imagesc(alldyad(:,:,midslice(rr))'), axis image, axis xy, axis off
    export_fig(out_slice)
    export_fig(out_slice_png)
    %pause(2)
    nii=make_nii(alldyad,img.hdr.dime.pixdim(2:4),[0 0 0],2);
    save_nii(nii,out_nii);
    
    %create pie chart showing proportion of voxels that contain 1,2,3 or 4
    %fibers;
    
    fract4=sum(dyad4.img(:))./sum(img.img(:));
    fract3=sum(dyad3.img(:))./sum(img.img(:));
    fract2=sum(dyad2.img(:))./sum(img.img(:));
    fract1=sum(img.img(:))./sum(img.img(:));
    
    pie4=fract4;
    pie3=fract3-fract4;
    pie2=fract2-fract3;
    pie1=fract1-fract2;

    pixels=sum(img.img(:));
    totalfibers=pixels*((4*pie4)+(3*pie3)+(2*pie2)+(pie1));
    
    gg=figure(1000+str2num(angle));
    set(gg,'Color','w')
    if (str2num(angle) < 45)
    map =[0 0 1
        0 1 0
        1 1 0];
    else
    map =[0 0 1
        0 1 0
        1 1 0
        1 0 0];
    end
    colormap (map);
    x=[pie1 pie2 pie3 pie4];
    x(x<0.0001)=[];
    labels = {};
    for LL = 1:numel(x)
        if (x(LL) > 0)
            labels{LL} = sprintf('%.2f%%',x(LL)*100);
            %'1 Fiber', '2 Fibers', '3 Fibers', '4 Fibers'};
        end
    end
    h=pie(double (x), zeros (size(x)),labels);
    %h=pie(double (x),labels);
    for LL = 1:numel(x)
        if (x(LL) > 0)
            h(LL*2).FontSize=14;
            label_Pos(LL,1:3)=h(LL*2).Position;
            %labels{LL} = sprintf('%.2f%%',x(LL)*100);
            %'1 Fiber', '2 Fibers', '3 Fibers', '4 Fibers'};
        end
    end
    
    if numel(x)>3
        pos3 = label_Pos(3,:);
        pos4 = label_Pos(4,:);
        dif = pos3 - pos4;
       distance = (sum(dif.^2))^(1/2)
       min_d=0.3;
       if distance < min_d
           delta = (min_d-distance)/2;      
           pieEdge3 = pos3/(sum(pos3.^2))^(1/2);
           pieEdge4 = pos4/(sum(pos4.^2))^(1/2);
           
           
           if (dif(1) > dif (2))
               if h(6).Position(1) > h(8).Position(1)
                   h(6).Position(1) = h(6).Position(1) + delta;
                   h(8).Position(1) = h(8).Position(1) - delta;
               else
                   h(6).Position(1) = h(6).Position(1) - delta;
                   h(8).Position(1) = h(8).Position(1) + delta;
               end
           else
               if h(6).Position(2) > h(8).Position(2)
                   h(6).Position(2) = h(6).Position(2) + delta;
                   h(8).Position(2) = h(8).Position(2) - delta;
               else
                   h(6).Position(2) = h(6).Position(2) - delta;
                   h(8).Position(2) = h(8).Position(2) + delta;
               end
           end
           
            Line3 = line([pieEdge3(1) (h(6).Position(1)-0.03*sign(h(6).Position(1)))],[pieEdge3(2) (h(6).Position(2)-0.03*sign(h(6).Position(2)))]);
            Line3.Color = [0 0 0];
            Line4 = line([pieEdge4(1) (h(8).Position(1)-0.03*sign(h(8).Position(1)))],[pieEdge4(2) (h(8).Position(2)-0.03*sign(h(8).Position(2)))]);
            %Line4 = line([pieEdge4(1) h(8).Position(1)],[pieEdge4(2) h(8).Position(2)]);
            Line4.Color = [0 0 0];
       end
   
    end
    
    
    
    %h(2,:).FontSize=14;
    export_fig(out_pie)
    export_fig(out_pie_png)
end
end