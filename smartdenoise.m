function re = smartdenoise(J, a, b, c)
re = J;
K = 15;
iter = 100;
ismed = 0;
if b >= 0.05 && b >= 2*a && b >= 2*c
	re = med(re);
	ismed = 1;
end
if 2*a > c
	if a >= 0.05
		re = wavelet(re);
	end
	if c >= 0.2
		re = smooth_diffusion(re,'pm1','cat','ns',iter,K, 0.3);
	end
	if (a >= 0.1 || b >= 0.05) && (ismed == 0)
		re = med(re);
	end
elseif c >= 0.05
	re = smooth_diffusion(re,'pm1','cat','ns',iter,K, 0.3);
	if b >= 0.1 && ismed == 0
		re = med(re);
	end
else
	if a >= 0.05
		re = wavelet(re);
	else if b >= 0.08 && ismed == 0
		re = med(re);
	end
end
end