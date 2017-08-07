function [ im ] = getRenderedImage(Mesh, cdata, az, el, upvec)
if ~exist('cdata', 'var'), cdata=zeros(size(Mesh.v,1), 1); end
if ~exist('az', 'var'), az=-45; end
if ~exist('el', 'var'), el=-120; end
if ~exist('upvec', 'var'), upvec=[0 1 0]; end



y=Mesh.v(:,2);
Mesh.v(:,2)=Mesh.v(:,3);
Mesh.v(:,3)=y;



patch('vertices', Mesh.v, 'faces',Mesh.f, ...
    'FaceVertexCData', cdata, ...
    'FaceColor', 'interp', 'CDataMapping', 'scaled', 'edgecolor', 'interp');
axis off;
axis equal;

zoom(0.6);

view(az, el);
camtarget([0 0 0]);
camproj('perspective');
set(gca,'CameraUpVector', upvec);
camtarget([0 0 0]);



% cameratoolbar('Show');
cameratoolbar('SetCoordSys', 'z');



end

