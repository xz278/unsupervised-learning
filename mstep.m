%% Maximization step of EM algorithm for Gaussian Mixture Models
% Input and Output:
% 	X: data;
% 	Q: complete probability from last iteration. n-by-k matrix
% 	miu: mean vector k-by-d matrix
% 	covmat: covariance matrix d-by-d
% 	pies: distribution of clusters
function [miu,covmat,pies]=mstep(X,Q,miu,covmat,pies)
	[n,d]=size(X);
	[~,k]=size(Q);
	for i=1:k
		dmt=sum(Q(:,i));
		miu(i,:)=sum(repmat(Q(:,i),[1,d]).*X,1)/dmt;
		pies(i)=sum(Q(:,i))/n;
		numerator=0;
		for j=1:n
			q=Q(j,i);
			xt=X(j,:);
			miuk=miu(i,:);
			numerator=numerator+q*(xt-miuk)'*(xt-miuk);
		end
		covmat{i}=numerator/dmt;
	end
