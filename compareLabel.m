% alpha=5

A=simMat(X,alpha);
[Y,V]=normcut(A,2);

ll=label(:,1)+1;
result=[Y(ll) label(:,2)]