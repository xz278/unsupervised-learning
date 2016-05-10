%% singlelink: function description
function Y=singlelink(X,k)
	[n,d]=size(X);
	C=X;
	Y=(1:n)';
	k2=size(C,1);
	if k2<=k
		fprintf('number of clusters needs to be larger than number of observations.\n');
		return;
	end
	max_dist=max(pdist(X));
	D=pdist2(X,X);
	while k2>k
		D=D+eye(k2)*max_dist;
		k2=k2-1;
		[~,row,col]=minInMat(D);
		if (row>col)
			larger=row;
			smaller=col;
		else
			larger=col;
			smaller=row;
		end
		Y(find(Y==larger))=smaller;
		larger_cluster_index=find(Y>larger);
		Y(larger_cluster_index)=Y(larger_cluster_index)-1;
		new_centroid=mean(X(find(Y==smaller),:),1);
		C(smaller,:)=new_centroid;
		C(larger,:)=[];
		D(larger,:)=[];
		D(:,larger)=[];
		newD=pdist2(C,new_centroid);
		new_d=size(newD.');
		D(smaller,:)=newD.';
	end
	Y=Y-1;
%--------------------- complete ----------------------------------
% function Y=singlelink(X,k)
% 	[n,d]=size(X);
% 	C=X;
% 	Y=(1:n)';
% 	k2=size(C,1);
% 	if k2<=k
% 		fprintf('number of clusters needs to be larger than number of observations.\n');
% 		return;
% 	end
% 	max_dist=max(pdist(X));
% 	D=pdist2(X,X);
% 	while k2>k
% 		D=D+eye(k2)*max_dist;
% 		k2=k2-1;
% 		[~,row,col]=minInMat(D);
% 		if (row>col)
% 			larger=row;
% 			smaller=col;
% 		else
% 			larger=col;
% 			smaller=row;
% 		end
% 		Y(find(Y==larger))=smaller;
% 		larger_cluster_index=find(Y>larger);
% 		Y(larger_cluster_index)=Y(larger_cluster_index)-1;
% 		new_centroid=mean(X(find(Y==smaller),:),1);
% 		C(smaller,:)=new_centroid;
% 		C(larger,:)=[];
% 		D(larger,:)=[];
% 		D(:,larger)=[];
% 		newD=pdist2(C,new_centroid);
% 		new_d=size(newD.');
% 		D(smaller,:)=newD.';
% 	end
% 	Y=Y-1;