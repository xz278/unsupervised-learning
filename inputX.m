%% load data from mouse
function [x,y,X,n]=inputX(k)
	if nargin==0
		[x,y]=ginput();
		X=[x y];
		n=size(x,1);
	else
		[x,y]=ginput(k);
		X=[x y];
		n=size(x,1);
	end
end