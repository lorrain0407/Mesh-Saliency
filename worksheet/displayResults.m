clf;
az = 129.142;
el = -71.946;
upvec = [0 1 0];

% M = [-1.04745556377108 -0.186594396656985 -0.270040305713152 0.740586677501039;-0.207041117588217 1.27133570236021 0.152057409704773 -0.816974520950495;-0.264389949452526 -0.256323759053334 0.950766415816326 4.55474982701315;0 0 0 1];
% M = [-13.558223189708 0 -3.42762692022285 8.49292505496543;0 14.2603093295707 0 -31.2895935172314;-0.240361330249352 -0.195626310798266 0.950766415816326 8.40286465046003;8.66025403784439 0 0 0]'


colormap('gray');

caxis([0 1]);

patch('vertices', Mesh.v, 'faces',Mesh.f, ...
    'FaceVertexCData', rand(size(Mesh.v,1),1), ...
    'FaceColor', 'interp', 'CDataMapping', 'scaled', 'EdgeColor','interp');


view(az, el);
set(gca,'CameraUpVector', upvec);
camproj('perspective');
axis equal;
axis vis3d;

lighting gouraud;
cameramenu;
cameratoolbar;
shading interp;
camlight;

%%
colormap('parula');
caxis([0 1]);
figure;
renderMesh(Mesh, meshSaliency);
