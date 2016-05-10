%% plotcluster3: function description
function plotcluster3(X,Y)
	close all
	axis equal
	ncluster=length(unique(Y))
	colors=getColors();
	scatter3(X(find(Y==0),1),X(find(Y==0),2),X(find(Y==0),3),'filled','MarkerFaceColor',colors(1,:));
	hold on
	for i=1:ncluster-1
		scatter3(X(find(Y==i),1),X(find(Y==i),2),X(find(Y==i),3),'filled','MarkerFaceColor',colors(i+1,:));
	end