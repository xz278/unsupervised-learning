%% compute k-mean clustering
%% input X is nxd points, k is number of clusters
%% output C is nx1 vector containing clustering information
function C=kmean(X,k,animation)
	[n,d]=size(X);
	C=zeros(n,1);
	if (k>n)
		fprintf('Number of clusters (K) has to be no less than number of input points n. \n');
		return;
	end
	colors='rbgc';
	x=X(:,1);
	y=X(:,2);
	if (animation)
		close all;
		plot(x,y,'k.');
		hold on;
	end
	clusterCenter=X(1:k,:); % initialize cluster centers to be the first K points 
	reassigned=true;
	while (reassigned)
		reassigned=false;
		for (j=1:n) % for each point j
			% calculate distances to each cluster i
			distToCenter=zeros(1,k);
			isClusterCenter=-1;
			for (i=1:k)
				if (x(j)==clusterCenter(i,1)&&y(j)==clusterCenter(i,2))
					isClusterCenter=i;
				else
					distToCenter(i)=distNorm(X(j,:),clusterCenter(i,:));
				end
			end
			[~,index]=sort(distToCenter);
			t=C(j); % previous cluster assignment
			if (isClusterCenter~=-1)
				C(j)=isClusterCenter;
			else
				C(j)=index(1); % reassign point j to closest cluster
			end
			if (t~=C(j))
				reassigned=true;
			end
		end
		% recalculate centers of clusters
		if (reassigned)
			% ClusterAssignmentIs=C
			for (j=1:k)
				pointsInCluster=find(C==j);
				clusterSize=size(pointsInCluster,1);
				if (clusterSize==0) % this should never happen
					fprintf('zero instances in cluser (%d) centered at (%d,%d)\n',j-1,cs(j,1),cs(j,2));
					clusterCenter(j,:)=zeros(1,d);
				else
					clusterCenter(j,:)=mean(X(pointsInCluster,:),1);
				end
			end
		end

		if (animation)
			h={};
			for (j=1:k)
				ps=find(C==j);
				xc=x(ps);
				yc=y(ps);
				h{j}=plot(xc,yc,[colors(j) 'o']);
			end
			pause();
			for (j=1:k)
				set(h{j},'visible','off')
			end	
		end
	end
	if (animation)
		h={};
		for (j=1:k)
			ps=find(C==j);
			xc=x(ps);
			yc=y(ps);
			h{j}=plot(xc,yc,[colors(j) 'o']);
		end
	end
end