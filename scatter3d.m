function h=scatter3d(X,color)
	h=scatter3(X(:,1),X(:,2),X(:,3),'filled','MarkerFaceColor',color);