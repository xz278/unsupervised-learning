function k=computeK(X,err,p)
	[n,d]=size(X);
	epsilon=err;
	delta=1-p;
	k=ceil(log(n/delta)/epsilon^2);