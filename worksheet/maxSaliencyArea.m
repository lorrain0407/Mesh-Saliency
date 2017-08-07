% [meshSaliency, az, el, az2, el2] = meshSaliencyPipeline(Mesh);

areaSaliency = zeros((numel(vertex)/3),1);
minV = zeros((numel(vertex)/3),1);
% geoDis = zeros((numel(vertex)/3),1);
% 
% for i = 1:numel(vertex)/3
%     for j = 1:numel(vertex)/3
%         geoDis(i,j) = geodis(vertex(i,:),vertex(j,:));
%     end
% end

for i = 1:numel(vertex)/3
     for j = 1:numel(vertex)/3
        if(D(i,j)<=3)
%         if(geoDis(i,j)<=0.5)
            areaSaliency(i,1) = areaSaliency(i,1) + meshSaliency(j);
        end
    end
end

[row,col]=find(areaSaliency==min(areaSaliency));

k = 1;
% minAreaSaliency = 0;
for j = 1:numel(vertex)/3
    if(D(row,j)<=3)
        minV(k,1) = j;
        k = k + 1;
%         minAreaSaliency = minAreaSaliency + meshSaliency(j);
    end
end

color = zeros(numel(vertex)/3,1);

minvertex = zeros(sum(minV~=0),3);
for j = 1:numel(vertex)/3
    if(minV(j,1)~=0)
        minvertex(j,:) = vertex(minV(j,1),:);
        color(minV(j,1),1) = 0.5;
    end
end

colormap('Autumn');
% color = mapminmax(color, 0.4, 0.6);

axis off;
axis equal;
axis vis3d;
cameratoolbar('Show');
cameratoolbar('SetMode', 'orbit');
cameratoolbar('SetCoordSys', 'z');
patch('Faces',face,'Vertices',vertex,'FaceVertexCData',color,'FaceColor','interp');
% patch('Vertices',minvertex,'green');

