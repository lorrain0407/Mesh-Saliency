% load('simplified_mesh.mat');
% load('dragon.mat');
[meshSaliency, az, el, az2, el2] = meshSaliencyPipeline(Mesh);

fprintf('az=%d, el=%d;\n', az, el);
figure;
renderMesh(Mesh, meshSaliency, az, el);

%%
% [meshSaliency, az1, el1] = meshSaliencyPipeline(Mesh);

fprintf('az1=%d, el1=%d;\n', az2, el2);
figure;
renderMesh(Mesh, meshSaliency, az2, el2);

% colormap('gray');
% caxis([0 1]);
% 
% figure;
% renderMesh(Mesh, meshSaliency, 290, 30)

% whitebg('blue');
whitebg('white');
%%
im=frame2im(getframe(gcf));
imwrite(im, 'test.png');

%%







% filenames = {'armadillo.ply', 'bun_zipper_res2.ply', 'dragon_vrip_res2.ply'};
% filenames = {'Armadillo.ply', 'cube.ply', 'bumpy.off', 'bunny.ply', 'horse_quad.ply', 'dragon_vrip_res2.ply'};
% fileIndex = 1;
% nface = 15000;
% [vertex,face] = read_mesh(filenames{fileIndex});
% 
% if numel(face)/3 > nface
%     [vertex,face] = perform_mesh_simplification(vertex,face,nface);
% end
% 
% Mesh.v = vertex;
% Mesh.f = face;
% 
% 
% 
% 
% %%
% 
% nface = 6000;
% kmzFiles = dir(fullfile('mesh/kmz', '*.kmz'));
% for i = 1:numel(kmzFiles)
%     
%     try 
%         tic;
%     kmzFiles(i).name
%     Mesh = importKmz(kmzFiles(i).name);
%     [vertex,face] = perform_mesh_simplification(Mesh.v,Mesh.f,nface);
%     Mesh.f = face;
%     Mesh.v = vertex;
% 
%     vtemp = Mesh.v(:,3);
%     Mesh.v(:,3) = Mesh.v(:,2); 
%     Mesh.v(:,2) = vtemp;
% %%
%     vmax = max(Mesh.v);
%     vmin = min(Mesh.v);
% 
%     vt = (Mesh.v-repmat(vmin,[size(Mesh.v,1) 1]));
%     vrange = max(vmax-vmin);
%     vrange = repmat(vrange, [size(vt,1) 3]);
%     Mesh.v = vt./vrange;
% 
%     vmax = max(Mesh.v);
%     Mesh.v = (Mesh.v-repmat(vmax./2,[size(Mesh.v,1) 1]));
%     %%
%     
%     save(sprintf('matlab_data/%s.mat', kmzFiles(i).name), 'Mesh');
%     [meshSaliency, az, el, az2, el2] = meshSaliencyPipeline(Mesh);
% 
%     
%     tt=toc;
%     
%     save(sprintf('matlab_data/%s.s.mat', kmzFiles(i).name), 'meshSaliency', 'az', 'el', 'az2', 'el2', 'tt');
% 
%     fprintf('az=%d, el=%d;\n', az, el);
%     f=figure('Visible','Off'); renderMesh(Mesh, meshSaliency, az, el);   
%     zoom(0.7);
%     saveas(f, sprintf('out/%s.mat.1.png', kmzFiles(i).name));
%     close(f);
% 
% 
%     f=figure('Visible','Off'); renderMesh(Mesh, meshSaliency, az2, el2);   
%     zoom(0.7);
%     saveas(f, sprintf('out/%s.mat.2.png', kmzFiles(i).name));
%     close(f);
% 
%     f=figure('Visible','Off'); renderMesh2(Mesh, az, el);   
%     zoom(0.7);
%     saveas(f, sprintf('out/%s.mat.3.png', kmzFiles(i).name));
%     close(f);
% 
%     f=figure('Visible','Off'); renderMesh2(Mesh, az2, el2);   
%     zoom(0.7);
%     saveas(f, sprintf('out/%s.mat.4.png', kmzFiles(i).name));
%     close(f);
% 
%     %%
%     
%     
%     
%     catch
%         toc
%         'cancelled'
%     end
% end