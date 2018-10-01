function bvec_plot(bvecs_csv,bvalue,do_surf,subset)

%% Preparation and options
max_bval=10000;
% prepare by deleting figure and gca
clf
delete(gca);

% handle convex hull surface option
if ~exist('do_surf','var')
    do_surf=0;
end


%% Data gathering and manipulation
% read the bvecs in from a comma separated values file
bvecs=csvread(bvecs_csv);

% remove bzeros, a single b0 will be explicitly added later
nonzero_inds=(sum(abs(bvecs),2))~=0;
bvecs=bvecs(nonzero_inds,:);

% handle the subset option
if ~exist('subset','var')
    subset=length(bvecs);
end
if subset>length(bvecs)
    display('subset is larger than number of directions in gradient matrix');
    return
end



% separate bvecs into x y and z components and multiply by bvalue
x=double(bvecs(1:subset,1));
y=double(bvecs(1:subset,2));
z=double(bvecs(1:subset,3));
x=x.*sqrt(bvalue);
y=y.*sqrt(bvalue);
z=z.*sqrt(bvalue);

%% Figure drawing

hold on

% % plot lines connecting antipodally symmetric points, commented out
% for i=1:length(x)
%     plot3([x(i),-x(i)],[y(i),-y(i)],[z(i),-z(i)],'-r')
% end

% set colormap to jet and plot q-space points colored by bvalue
% note that antipodally symmetric points are also plotted
colormap jet
map=colormap;
for i=1:length(x)
    colormap_ind=floor((length(map).*((sqrt(x(i).^2+y(i).^2+z(i).^2))./max_bval)));
    if colormap_ind==0;
        colormap_ind=1;
    end
    plot3(x(i),y(i),z(i),'ro','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor',map(colormap_ind,:));
    % for antipodal symmetry
    %plot3(-x(i),-y(i),-z(i),'ro','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor',map(colormap_ind,:));
    plot3(0,0,0,'ro','MarkerSize',15,'MarkerEdgeColor','k','MarkerFaceColor',map(1,:));
end

% % display the colorbar with the correct scale
% set(gcf,'DefaultTextColor','w');
% h=colorbar;
% set(h,'location','WestOutside');
% set(h,'position',[0.33 0.218 0.02 0.54]);
% set(gca,'CLim',[0 max_bval]);
% set(gca,'FontName','Arial','color','w');
% %set(gcf,'color','k');
% title(h,{'b-value','(s/mm^{2})'},'FontSize',28,'FontWeight','bold','color','w');
% %get(h,'position')
% set(h,'FontSize',24,'FontWeight','bold');
% set(h,'YColor','w');


%'position',[pos(1).*0.38, pos(2).*2.3, pos(3).*1.5, pos(4).*0.65],'FontSize',18,'CLim',[0,bvalue]);
%set(gca,'CLim', [0,bvalue]);

colormap_ind=floor((length(map).*bvalue/max_bval));

% do convex hull surface if requested
if do_surf==1
    % account for antipodal symmetry
    x=[x;-x];
    y=[y;-y];
    z=[z;-z];
    K=convhull(x,y,z);
    trisurf(K,x,y,z,1,'FaceColor',map(colormap_ind,:),'EdgeColor','red','FaceAlpha',0.7);
% if convex hull is not used then plot a sphere
else
    quality=50;
    [x1,y1,z1]=sphere(quality);
    surf(bvalue*x1,bvalue*y1,bvalue*z1,'EdgeColor','black','EdgeAlpha',0.4,'FaceColor',map(colormap_ind,:),'FaceAlpha',0.3);
end


% set visualization parameters
axis off
camlight right; lighting phong
axis vis3d
axis equal
view(20,60);


%% Save output
[path name ext]=fileparts(bvecs_csv);
export_fig(['~/Desktop/' name '.png']);