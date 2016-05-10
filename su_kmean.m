%% semi-supervised k-mean
% input X: nxd, each row is one obervation
% k: number of cluster
% Y: clusters [0..k]
function Y=su_kmean(X,k,label)
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
	% C(1,:)=X(ceil(rand*n),:);
	% for i=2:k
	% 	DtoC=min(pdist2(X,C),[],2);
	% 	a=sum(DtoC);
	% 	P=DtoC/a;
	% 	% [P_sorted,idx]=sort(P);
	% 	C(i,:)=X(find(rand<cumsum(P),1),:);
	% end

% initialize useing label
	supervised_obser=label(:,1)+1;
	supervised_label=label(:,2)+1;
	unique_label=unique(supervised_label);
	Y=zeros(n,1);
	C=zeros(k,d);
	for i=1:length(unique_label)
		idx=supervised_obser(find(supervised_label==i));
		C(i,:)=mean(X(idx,:),1);
		Y(idx)=i;
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
		for i=1:length(unique_label)
			idx=supervised_obser(find(supervised_label==i));
			Y(idx)=i;
		end
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
