%% compute similarity graph matrix
%% input X n*d
%% output A n*n
function A=simMat(X)
	distance_matrix=pdist2(X,X);
	stand_deviation=std2(distance_matrix);
	delta=stand_deviation/10;
	A=exp(-distance_matrix.^2./(2*delta^2));
end