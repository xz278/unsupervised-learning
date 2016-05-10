%% MLE estimator of gaussian mixture model
% Input: 
% 	X: n obervations of dimention d, n-by-d matrix
% 	Q: P(Ct|Xt,theta)
% 	miu: mean vector 
% 	sigma: covariance matrix
% 	pies: distribution over clusters
% Output:
% 	mle_est: mle estimator
function mle_est=mle_gaussian(X,Q,miu,sigma,pies)
    mle_est=0;
	[n,d]=size(X);
	[~,k]=size(Q);
	for i=1:n
		for j=1:k
			mle_est=mle_est+Q(i,j)*log(mvnpdf(X(i,:),miu(j,:),sigma{j})*pies(j));
		end
	end