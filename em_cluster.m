%% em_cluster: Algorithm for EM cluster for Mixture Gaussian
% Input X, n-by-d matrix. n observations in d dimentions
% Input k: number of cluster
function Y=em_cluster(X,k,threshold,lmt)
	% initialization: k random data points for each miuk
	mean_vector=X(1:k,:);		% mean vector the multivariant gaussian for each cluster k-by-d matrix
	covariance={};				% covariance matrix d-by-d
	[n,d]=size(X);
	% init_cov=cov(X)+eye(d)*eps;	
	Y=kmean(X,k);
	for i=1:k
		curr_cluster=X(find(Y==i-1),:);
		mean_vector(i,:)=mean(curr_cluster,1);
		covariance{i}=cov(curr_cluster)+eye(size(d,1))*eps;
	end
	Q=zeros(n,k);				% cluster probability conditinoal on data and model parameter
	pies=ones(1,k)*(1/k);				
	mle_est=0;

	% start iterating
	flag_stop=false;
	steps=0;
	while ~flag_stop && steps<lmt
		steps=steps+1
		Q=estep(X,Q,mean_vector,covariance,pies);
		[mean_vector,covariance,pies]=mstep(X,Q,mean_vector,covariance,pies);
		new_mle_est=mle_gaussian(X,Q,mean_vector,covariance,pies);
		if (new_mle_est-mle_est<threshold)
			break;
		end
		% new_mle_est
		mle_est=new_mle_est;
		% Q(1,:)
	end

	Y=zeros(n,1);
	for i=1:n
		[~,idx]=max(Q(i,:));
		Y(i)=idx-1;
	end