function [m,row,col]=minInMat(X)
	[n,d]=size(X);
	if (n==1)
		row=1;
		[m,col]=min(X);
	elseif (d==1)
		col=1;
		[m,row]=min(X);
	else	
		[tm,idx]=min(X);
		[m,idx2]=min(tm);
		col=idx2;
		row=idx(col);
	end
