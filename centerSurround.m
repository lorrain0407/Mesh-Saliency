% Use weighted average values to compute saliency at a scale level
function [levelSaliency] = centerSurround(Mesh, curvature, sigma)
    global cache_;

    if ~isfield(cache_, 'weightedAverage')
        cache_.weightedAverage = containers.Map('KeyType','double','ValueType','any');
    end

    if ~cache_.weightedAverage.isKey(sigma)
        weightedAvg1 = computeWeightedAverage(Mesh, curvature, sigma);
        cache_.weightedAverage(sigma) = weightedAvg1;
    end
    weightedAvg1 = cache_.weightedAverage(sigma);

    if ~cache_.weightedAverage.isKey(sigma*2)
        weightedAvg2 = computeWeightedAverage(Mesh, curvature, sigma*2);
        cache_.weightedAverage(sigma*2) = weightedAvg2;
    end
    weightedAvg2 = cache_.weightedAverage(sigma*2);

    levelSaliency = abs(weightedAvg1-weightedAvg2);
end
