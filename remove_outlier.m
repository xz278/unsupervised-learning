%% remove_outlier: function description
function Y=remove_outlier(X,k)
	miu=mean(X,1);
	dist_to_miu=pdist2(X,miu);
	[sorted_d,idx]=sort(dist_to_miu);
	Y=X;
	for i=1:k
		Y(idx(i),:)=miu;
	end