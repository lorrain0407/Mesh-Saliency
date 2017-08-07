function varargout = drawPlane3d(plane, varargin)
%DRAWPLANE3D Draw a plane clipped in the current window
%
%   drawPlane3d(plane)
%   plane = [x0 y0 z0  dx1 dy1 dz1  dx2 dy2 dz2];
%
%   See also
%   planes3d, createPlane
%
%   Example
%   p0 = [1 2 3];
%   v1 = [1 0 1];
%   v2 = [0 -1 1];
%   plane = [p0 v1 v2];
%   axis([-10 10 -10 10 -10 10]);
%   drawPlane3d(plane)
%   drawLine3d([p0 v1])
%   drawLine3d([p0 v2])
%   set(gcf, 'renderer', 'zbuffer');
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% INRA - TPV URPOI - BIA IMASTE
% created the 17/02/2005.
%

%   HISTORY
%   2008-10-30 replace intersectPlaneLine by intersectLinePlane, add doc
%   2010-10-04 fix a bug for planes touching box by one corner
%   2011-07-19 fix a bug for param by Xin KANG (Ben)
% 

% default display
options = {'FaceColor', 'm'};

% parse input arguments if any
if ~isempty(varargin)
    options = varargin;
    
    % if option is a single argument, assume it corresponds to plane color
    if length(options) == 1
        options = {'FaceColor', options{1}};
    end
    
    % if options are specified as struct, need to convert to parameter
    % name-value pairs
    if isstruct(options{1})
        s = options{1};
        options = [fieldnames(s) struct2cell(s)]';
        options = options(:)';
    end
end

% extract axis bounds to crop plane
lim = get(gca, 'xlim');
xmin = lim(1);
xmax = lim(2);
lim = get(gca, 'ylim');
ymin = lim(1);
ymax = lim(2);
lim = get(gca, 'zlim');
zmin = lim(1);
zmax = lim(2);


% create lines corresponding to cube edges
lineX00 = [xmin ymin zmin 1 0 0];
lineX01 = [xmin ymin zmax 1 0 0];
lineX10 = [xmin ymax zmin 1 0 0];
lineX11 = [xmin ymax zmax 1 0 0];

lineY00 = [xmin ymin zmin 0 1 0];
lineY01 = [xmin ymin zmax 0 1 0];
lineY10 = [xmax ymin zmin 0 1 0];
lineY11 = [xmax ymin zmax 0 1 0];

lineZ00 = [xmin ymin zmin 0 0 1];
lineZ01 = [xmin ymax zmin 0 0 1];
lineZ10 = [xmax ymin zmin 0 0 1];
lineZ11 = [xmax ymax zmin 0 0 1];


% compute intersection points with each plane
piX00 = intersectLinePlane(lineX00, plane);
piX01 = intersectLinePlane(lineX01, plane);
piX10 = intersectLinePlane(lineX10, plane);
piX11 = intersectLinePlane(lineX11, plane);
piY00 = intersectLinePlane(lineY00, plane);
piY01 = intersectLinePlane(lineY01, plane);
piY10 = intersectLinePlane(lineY10, plane);
piY11 = intersectLinePlane(lineY11, plane);
piZ00 = intersectLinePlane(lineZ00, plane);
piZ01 = intersectLinePlane(lineZ01, plane);
piZ10 = intersectLinePlane(lineZ10, plane);
piZ11 = intersectLinePlane(lineZ11, plane);

% concatenate points into one array
points = [...
    piX00;piX01;piX10;piX11; ...
    piY00;piY01;piY10;piY11; ...
    piZ00;piZ01;piZ10;piZ11;];

% check validity: keep only points inside window (with tolerance)
ac = 1e-14;
ivx = points(:,1) >= xmin-ac & points(:,1) <= xmax+ac;
ivy = points(:,2) >= ymin-ac & points(:,2) <= ymax+ac;
ivz = points(:,3) >= zmin-ac & points(:,3) <= zmax+ac;
valid = ivx & ivy & ivz;
pts = unique(points(valid, :), 'rows');

% If there is no intersection point, escape.
if size(pts, 1) < 3
    disp('plane is outside the drawing window');
    return;
end

% the two spanning lines of the plane
d1 = plane(:, [1:3 4:6]);
d2 = plane(:, [1:3 7:9]);

% position of intersection points in plane coordinates
u1 = linePosition3d(pts, d1);
u2 = linePosition3d(pts, d2);

% reorder vertices in the correct order
ind = convhull(u1, u2);
ind = ind(1:end-1);

% draw the patch
h = patch('XData', pts(ind, 1), 'YData', pts(ind, 2), 'ZData', pts(ind, 3));
set(h, options{:});

% return handle to plane if needed
if nargout > 0
    varargout = {h};
end
