%% a function to plot clusters
%% input X is original data nxd, C is cluster assignments nx1
function plotCluster(X,C)
	close all;
	hold on;
	axis equal
	% plot(X(:,1),X(:,2),'k.');
% 	c=size(unique(C),1);
    c=max(C);
	colors='rbgcym';
	nc=size(colors,2);
	% if (c>nc)
	% 	fprintf('number of clusters not supported. \n');
	% 	return;
	% end
	for (i=1:c)
		curr=find(C==i);
		x=X(curr,1);
		y=X(curr,2);
		plot(x,y,[colors(i) '.'],'markers',15);
    end


end