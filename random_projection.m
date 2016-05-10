function [Y,W,k]=random_projection(X,err,p)
	% use err=0.2, p=0.99 for task1
	[n,d]=size(X);
	epsilon=err;
	delta=1-p;
	k=ceil(log(n/delta)/epsilon^2);
	% k=30;
	W=sign(rand(d,k)-0.5)/sqrt(k);
	Y=X*W;
	% Y=1;
	% W=1;
	