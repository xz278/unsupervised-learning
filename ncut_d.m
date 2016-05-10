%% ncut_d: perform cluster given distance matrix D and k
function Y=ncut_d(distance_matrix,k)
	[n,~]=size(distance_matrix);
	if k>n
		Y=0;
		fprintf('number of clusters needs to be larger than number of observation');
	end

% % =================== Original =======================
% 	distance_matrix=pdist2(X,X);
% 	stand_deviation=std2(distance_matrix);
% 	delta=stand_deviation/10;
% 	A=exp(-distance_matrix.^2./(2*delta^2));
% % =================== Original =======================

	% inf_idx=find(distance_matrix==Inf);
	% distance_matrix(inf_idx)=0;
	% max_val=max(max(distance_matrix));
	% distance_matrix(inf_idx)=max_val;
	stand_deviation=std2(distance_matrix);
	% threshold=max(min(distance_matrix+eye(n)*max(max(distance_matrix))));
	% threshold_matrix=distance_matrix<=threshold;
	delta=stand_deviation/10;
	% delta=1;
	A=exp(-distance_matrix.^2./(2*delta^2));
	% A=threshold_matrix;

	D=zeros(n,n);
	for (i=1:n)
		D(i,i)=sum(A(i,:));
	end
	% L_unnormalized=D-A;
	I=eye(n);
	L=I-D^(-1/2)*A*D^(-1/2);
	% Y=0;
	% V=0;
	[V,~]=eigs(L,k,eps);
	Y=kmean(V,k);
end