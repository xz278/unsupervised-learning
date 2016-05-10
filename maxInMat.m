% function [m,idx]=maxInMat(X)
% 	[n,d]=size(X);
% 	if (n==1 || d==1)
% 		[m,idx]=max(X);
% 	else
% 		[tm,tidx]=max(X);
% 		[m,t2idx]=max(tm);
% 		idx=n*(t2idx-1)+tidx(t2idx);
% 	end

function [m,row,col]=maxInMat(X)
	[n,d]=size(X);
	if (n==1)
		row=1;
		[m,col]=max(X);
	elseif (d==1)
		col=1;
		[m,row]=max(X);
	else	
		[tm,idx]=max(X);
		[m,idx2]=max(tm);
		col=idx2;
		row=idx(col);
	end
