function [suppressedLevelSaliency] = nonlinearSuppression(Mesh, levelSaliency, sigma)
    global cache_ params_;
    if ~isfield(cache_, 'D');
        cache_.D = pdist2(Mesh.v, Mesh.v);
    end
    D = cache_.D;
    if ~isfield(cache_, 'avgDist');
        D_ = D;
        D_(D==0) = Inf;
        cache_.avgMinDist = mean(min(D_,[],2));
    end
    avgMinDist = cache_.avgMinDist;

    levelSaliency = normalizeRange(levelSaliency);
    
    levelSaliencyMat = repmat(levelSaliency, [1 size(D, 1)]);
    levelSaliencyMat(D > params_.windowSize) = -Inf;

    [globalMax,globalMaxI] = max(levelSaliency);

    [~,maxI] = max(levelSaliencyMat,[],2);
    isLocalMax=(maxI==(1:size(levelSaliencyMat,1))');
    isLocalMax(globalMaxI)=0;

    meanLocMax = mean(levelSaliency(isLocalMax));

    suppressedLevelSaliency = levelSaliency*(globalMax-meanLocMax)^2;
end
