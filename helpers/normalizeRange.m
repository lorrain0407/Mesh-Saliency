function [fA] = normalizeRange(A)
minA = min(A);
fA = (A-minA)/(max(A)-minA);
end