function Y=singlelink_a(A,k)
	[n,~]=size(A);
	A=(A+eps).*(eye(n)==0);
	C=A;		% similarity between clusters
	Y=(1:n)';
	k2=size(C,1);
	while k2>k
		k2=k2-1;
		[m,row,col]=maxInMat(C);
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
		C(larger,:)=[];
		C(:,larger)=[];
		new_similarity=zeros(1,k2);
		for i=1:k2
			if i==smaller
				continue;
			end
			[max_similarity,~,~]=maxInMat(A(find(Y==smaller),find(Y==i)'));
			new_similarity(i)=max_similarity;
		end
		C(smaller,:)=new_similarity;
		C(:,smaller)=new_similarity';
	end
	Y=Y-1;