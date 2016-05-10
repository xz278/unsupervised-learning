%% pca_svd: function description
function [Y,W]=pca_svd(X,k)
	[n,d]=size(X);
	miu=mean(X,1);
	X_centered=X-repmat(miu,n,1);
	[U,~,~]=svd(X_centered',0);
	W=U(:,1:k);
	Y=X_centered*W;
