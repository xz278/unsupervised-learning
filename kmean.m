% input X: nxd, each row is one obervation
% k: number of cluster
% Y: clusters [0..k]
function [Y] = kmean(X,k)
	[n,d]=size(X);
	if (k>n)
		fprintf('cluter size needs to be larger than number of obervation');
		Y=0;
		return
	end
	% initialize cluster centers kxd
	% for (i=1:k)
	% 	Y(i)=i;
	% end	
	% if k==2
	% 	D=pdist2(X,X);
	% 	[m,row,col]=maxInMat(D);
	% 	C=X([row;col],:);
	% else
	% 	C=X(1:k,:); % cluster centers
	% end

% k-mean++ to initialize the centroids
	C(1,:)=X(ceil(rand*n),:);
	for i=2:k
		DtoC=min(pdist2(X,C),[],2);
		a=sum(DtoC);
		P=DtoC/a;
		% [P_sorted,idx]=sort(P);
		next_centroid=find(rand<cumsum(P),1);
		l=length(next_centroid);
		cnt=0;
		while l==0
			cnt=cnt+1;
			if cnt==1
				C(1,:)
			end
			next_centroid=find(rand<cumsum(P),1);
			l=length(next_centroid);
		end
		C(i,:)=X(next_centroid,:);
	end

	Y=zeros(n,1);

	flag_changed=true;

	show_steps=false;

% ----------------- visualization BELOW---------------------------------
	if show_steps
		close all
		plot(X(:,1),X(:,2),'.');
		hold on
		axis equal
		colors='rbgcym';
		for (i=1:k)
			plot(C(i,1),C(i,2),[colors(i),'x'],'markers',15);
		end
		pause()
	end
% ----------------- visualization ABOVE---------------------------------

	while flag_changed
		td=pdist2(X,C);
		oldY=Y;
		[~,Y]=min(td,[],2);
		for (j=1:k)
			curr_cluster=X(find(Y==j),:);
			C(j,:)=mean(curr_cluster,1);
		end
		flag_changed=~isequal(oldY,Y);
% ----------------- visualization BELOW---------------------------------
		if show_steps
			close all
			axis equal
			hold on
			for (j=1:k)
				plot(C(j,1),C(j,2),[colors(j),'x'],'markers',15);
				plot(X(find(Y==j),1),X(find(Y==j),2),[colors(j),'.']);
			end
			% Y
			% C
			pause()
		end
% ----------------- visualization ABOVE---------------------------------
	end
	Y=Y-1;
