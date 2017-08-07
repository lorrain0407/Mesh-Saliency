function [az, el, az2, el2] = salientViewpoint(Mesh, meshSaliency)
    views = {};

    fig = figure('Visible','Off');
    set(fig, 'Position', [0 0 200 200]);
    colormap(fig, 'gray');
    caxis([0 1]);

    ax = findall(fig,'type','axes');
    getRenderedImage(Mesh, meshSaliency, 0, 30)

    count = 1;
    azel = {};
    fig.Color = [0 0 0];
    for j = [2, 13, 26, 40]
%     for j = [20]
        for i = 1:15
            view(ax, 360/15*i, j);
            im=im2double(frame2im(getframe(fig)));
            views{count} = double(im.^8);
            azel{count} = [360/15*i, j];
%             imwrite(im, sprintf('%.3d-%.3d-%.5d.png', i,j, sum(views{count}(:))));
            count = count + 1;
        end
    end
    close(fig);

    maxV = -Inf;
    count = 1;
    for i = 1:numel(views)
        v = sum(views{count}(:));
        if maxV < v
            az = azel{count}(1);
            el = azel{count}(2);
            maxV = v;
            
        end
        count = count + 1;
    end

    maxV = Inf;
    for i = 1:numel(views)
        v = sum(views{i}(:));
        if maxV > v
            az2 = azel{i}(1);
            el2 = azel{i}(2);
            maxV = v;
        end
    end
end
