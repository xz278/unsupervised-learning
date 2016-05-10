%% ncut_a: Perform normalized cut given similarity matrix A, and number of cluster k
function Y=ncut_a(A,k)
	[n,~]=size(A);
	if k>n
		fprintf('Invalid k.\n');
		return;
	end
	A=A>0;
	D=zeros(n,n);
	for (i=1:n)
		D(i,i)=sum(A(i,:));
	end
	I=eye(n);
	L=I-D^(-1/2)*A*D^(-1/2);
	[V,~]=eigs(L,k,eps);
	Y=kmean(V,k);
	
