function [vertex,face] = perform_mesh_simplification(vertex,face,nface)

% perform_mesh_simplification - simplify a 3D mesh
%
%   [vertex,face] = perform_mesh_simplification(vertex,face,nface);
%
%   This is a simple wrapper to QSlim command line software
%       http://graphics.cs.uiuc.edu/~garland/software/qslim.html
%   The methode is based on the following paper
%       Michael Garland and Paul Heckbert, 
%       Surface Simplification Using Quadric Error Metrics, 
%       SIGGRAPH 97
%
%   Copyright (c) 2006 Gabriel Peyr?

if nargin<3
    error('Usage: [vertex,face] = perform_mesh_simplification(vertex,face,nface).');
end

% write input in smf format
write_smf('tmp.smf', vertex, face);

% perform simplication
system(['qslim -o tmp1.smf -t ' num2str(nface) ' tmp.smf']);

% read back result
[vertex,face] = read_mesh('tmp1.smf');

% delete temporary files
delete 'tmp.smf';
delete 'tmp1.smf';