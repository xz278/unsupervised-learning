%% ncut: perform normalized cut
% input X: nxd,each row is an observation
% input k: number of clusters
function Y=ncut(X,k)
% function [Y,V,L]=ncut(X,k)
	[n,d]=size(X);
	if k>n
		Y=0;
		fprintf('number of clusters needs to be larger than number of observation');
	end

% % =================== Original =======================
% 	distance_matrix=pdist2(X,X);
% 	stand_deviation=std2(distance_matrix);
% 	delta=stand_deviation/10;
% 	A=exp(-distance_matrix.^2./(2*delta^2));
% % =================== Original =======================

	distance_matrix=pdist2(X,X);
	stand_deviation=std2(distance_matrix);
	delta=stand_deviation/10;
	A=exp(-distance_matrix.^2/(2*delta^2));

	D=zeros(n,n);
	for (i=1:n)
		D(i,i)=sum(A(i,:));
	end
	% D(D==0)=0.001;
	I=eye(n);
	L=I-D^(-0.5)*A*D^(-0.5);
	warning off
	[V,~]=eigs(L,k,eps);
	warning on
	Y=kmean(V,k);
end
