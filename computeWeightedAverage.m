function [weightedAverage,basis] = computeWeightedAverage(Mesh, curvature, sigma)
    global cache_;
    
    if ~isfield(cache_, 'D')
        cache_.D = pdist2(Mesh.v, Mesh.v); 
    end
    
    tic
    basis = exp(-0.5.*(cache_.D./sigma).^2);
    basis(cache_.D >= 2*sigma) = 0;
    toc
    
%     weightedAverage = sum((repmat(curvature.c', [size(basis, 1) 1]) .* basis),2)./sum(basis, 2);
    if(isstruct(curvature))
        weightedAverage = sum((repmat(curvature.c', [size(basis, 1) 1]) .* basis),2)./sum(basis, 2);
    else
        weightedAverage = sum((repmat(curvature', [size(basis, 1) 1]) .* basis),2)./sum(basis, 2);
    end
    
end
