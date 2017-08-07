% Compute mean curvature
function [Cmean] = computeCurvature(Mesh)
    [~,~,~,~,Cmean,~,~] = compute_curvature(Mesh.v,Mesh.f);
end
