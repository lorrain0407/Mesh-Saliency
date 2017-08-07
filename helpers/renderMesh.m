function renderMesh(Mesh, vertexColors, az, el, upvec)
if ~exist('vertexColors', 'var'), vertexColors=zeros(size(Mesh.v,1), 1); end
if ~exist('az', 'var'), az=-45; end
if ~exist('el', 'var'), el=-120; end
if ~exist('upvec', 'var'), upvec=[0 1 0]; end


y=Mesh.v(:,2);
Mesh.v(:,2)=Mesh.v(:,3);
Mesh.v(:,3)=y;

patch('vertices', Mesh.v, 'faces',Mesh.f, ...
    'FaceVertexCData', vertexColors, ...
    'FaceColor', 'interp', 'CDataMapping', 'scaled', 'edgecolor', 'interp');
%, 'EdgeColor','flat');

axis off;
axis equal;
axis vis3d;

view(az, el);

camtarget([0 0 0]);

camproj('perspective');

% lighting gouraud;
cameramenu;
% shading interp;
% camlight('headlight')
set(gca,'CameraUpVector', upvec);


cameratoolbar('Show');
cameratoolbar('SetMode', 'orbit');
cameratoolbar('SetCoordSys', 'z');


end

