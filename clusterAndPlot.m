function Y=clusterAndPlot(X,k,method,plot_cluster)
	if (strcmp('sc',method))
		Y=ncut(X,k);
	end
	if (strcmp('kmean',method))
		Y=kmean(X,k);
	end
	if (strcmp('singlelink',method))
		Y=singlelink(X,k);
	end
	if (plot_cluster)
		plotCluster(X,Y+1);
	end
end