% alpha=0.01
function A=DtoA(D)
	stand_deviation=std2(D);
	A=exp(-D.^2/(2*stand_deviation^2));