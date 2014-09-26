function v = psnr(I, J)
	s = size(I);
	if length(s) == 3
		msn = mean(mean(mean((I-J).^2)));
	else
		msn = mean(mean((I-J).^2));
	end
	v = 10*log(255*255/msn)/log(10);
end