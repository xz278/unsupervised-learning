%% ncut: perform normalized cut
% input X: nxd,each row is an observation
% input k: number of clusters
function Y=su_ncut(X,k,label)
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
	threshold=max(min(distance_matrix+eye(n)*max(max(distance_matrix))));
	threshold_matrix=distance_matrix<=threshold;
	delta=stand_deviation/10;
	% delta=stand_deviation;
	A=exp(-distance_matrix.^2./(2*delta^2));
	% A=threshold_matrix;

	D=zeros(n,n);
	for (i=1:n)
		D(i,i)=sum(A(i,:));
	end
	% L_unnormalized=D-A;
	I=eye(n);
	L=I-D^(-1/2)*A*D^(-1/2);
	% Y=0;
	% V=0;
	[V,~]=eigs(L,k,eps);
	Y=su_kmean(V,k,label);
end
