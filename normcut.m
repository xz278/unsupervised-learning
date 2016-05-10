%% normlized cut algorithm
%% input is similarity matrix A of size nxn, k is number of clusters
%% output Y is the cluster, V are the eigenvectors
function [Y,V]=normcut(A,k)
	[~,n]=size(A);
	% calculate diagnal matrix
	D=zeros(n,n);
	for (i=1:n)
		D(i,i)=sum(A(i,:));
	end
	% compute normalized Laplacian matrix L
	I=eye(n);
	L=I-D^(-1/2)*A*D^(-1/2);
	[V,~]=eigs(L,k,eps);
	
	% L=D^(-1/2)*A*D^(-1/2);
	% [V,~]=eigs(L,k);
	Y=kmean(V,k,false);
end