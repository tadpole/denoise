function re = smartdenoise(J, a, b, c)
re = J;
K = 15;
iter = 100;
ismed = 0;
if (a+b+c < 20)
	return
end
if b >= 50 && b >= 2*a && b >= 2*c
	re = med(re);
	ismed = 1;
end
if 2*a > c
	if a >= 10
		re = wavelet(re);
	end
	if c >= 10
		re = smooth_diffusion(re,'pm1','cat','ns',iter,K, 0.3);
	end
	if (a >= 60 || b >= 20) && (ismed == 0)
		re = med(re);
	end
elseif c >= 10
	re = smooth_diffusion(re,'pm1','cat','ns',iter,K, 0.3);
	if b >= 10 && ismed == 0
		re = med(re);
	end
else
	if a >= 20
		re = wavelet(re);
	else if b >= 10 && ismed == 0
		re = med(re);
	end
end
end