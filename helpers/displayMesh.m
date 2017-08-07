function displayMesh(Mesh, params)
if(nargin < 2)
    params = struct('edgecolor','black','markercolor','green','alpha', 0.1);
end


if size(Mesh.v, 2) ~= 3
    Mesh.v = Mesh.v';
    warning('displayMesh: input size should be n by 3');
end

assert(size(Mesh.v, 2) == 3);


%trimesh(Mesh.f',Mesh.v(1,:),Mesh.v(2,:),Mesh.v(3,:),'edgecolor', params.edgecolor,'facecolor',params.edgecolor,'facealpha',.3);
% h=trimesh(Mesh.f',Mesh.v(:,1),Mesh.v(:,2),Mesh.v(:,3),'edgecolor',params.edgecolor,'FaceAlpha', 0.8*params.alpha, 'EdgeAlpha', 0.4*params.alpha);
% trimesh(Mesh.f,Mesh.v(:,1),Mesh.v(:,2),Mesh.v(:,3),'edgecolor',params.edgecolor);
trimesh(Mesh.f,Mesh.v(:,1),Mesh.v(:,2),Mesh.v(:,3));
% get(h);


setfig();

if(isfield(Mesh,'I'))
    plot3(Mesh.I(:,1),Mesh.I(:,2),Mesh.I(:,3),'x','MarkerEdgeColor',params.markercolor,'MarkerSize',10,'linewidth',3);
end

if(isfield(Mesh,'bb'))
    plot3(Mesh.bb(1,:),Mesh.bb(2,:),Mesh.bb(3,:),'-xr')
    labels = cellstr( num2str([1:size(Mesh.bb,2)]') );
    text(Mesh.bb(1,:),Mesh.bb(2,:),Mesh.bb(3,:), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')


end