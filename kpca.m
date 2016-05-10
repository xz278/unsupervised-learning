function Y=kpca(X,k)
	% compute kernal
	[n,d]=size(X);
	delta=0.02;
	D=pdist2(X,X);
	kf=exp(-delta*D.^2); % kernal function
	K=kf-repmat(sum(kf,1)/n,[n,1])-repmat(sum(kf,2)/n,[1,n])+sum(kf(:))/n^2;
	[A,numbda]=eigs(K,k);
	ev=repmat(diag(numbda)',[n,1]);
	P=A./ev;
	Y=K*P;