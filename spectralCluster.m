%% function to perform spectral clustering
function [Y,V]=spectralCluster(X,k,alpha)
	% compute similarity matrix A
	[n,d]=size(X);
	A=simMat(X,alpha);
	[Y,V]=normcut(A,k);
end