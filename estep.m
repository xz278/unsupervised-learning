%% estep: E-step for EM algorithm for Gaussian
% Input: 
% 	X: data;
% 	Q: complete probability from last iteration. n-by-k matrix
% 	miu: mean vector, k-by-d matrix
% 	covmat: covariance matrix, a cell array of k d-by-d matrix
% 	p: distribution of clusters
% Output:
	% Q: new complete probability
	% diff: difference from last iteration, used to determine convergence
function [Q]=estep(X,Q,miu,covmat,p)
	oldQ=Q;
	[n,k]=size(Q);
	[~,d]=size(X);
	for i=1:n
		px=zeros(1,k);
		denominator=0;
		for j=1:k
			miu_j=miu(j,:);
			x_i=X(i,:);
			sigma_j=covmat{j};
			px(j)=mvnpdf(x_i,miu_j,sigma_j);
			denominator=denominator+px(j)*p(j);
		end

		for j=1:k
			Q(i,j)=px(j)*p(j)/denominator;
		end
	end
