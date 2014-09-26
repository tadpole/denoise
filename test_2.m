function [re, re2] = test_2(I, gauss, salt, speckle)
J = I;
t = '';
if ~exist('gauss')
	gauss = 0.0;
end
if ~exist('salt')
	salt = 0.0;
end
if ~exist('speckle')
	speckle = 0.0;
end
if speckle ~= 0.0
	J = imnoise(J, 'speckle', speckle);
	t = [t, ' speckle ', num2str(speckle)];
end
if gauss ~= 0.0
	J = imnoise(J, 'gaussian', 0, gauss);
	t = [t, ' guass ', num2str(gauss)];
end
if salt ~= 0.0
	J = imnoise(J, 'salt & pepper', salt);
	t = [t, ' salt ', num2str(salt)];
end


K = 15;
iter = 100;

K1 = med(J);
K2 = wavelet(J);
K3 = smooth_diffusion(J,'pm1','cat','ns',iter,K, 0.3);
s = predict(getparm(J));
K5 = smartdenoise(J, s(1), s(2), s(3));
re = [ssim(I, J), ssim(I, K1), ssim(I, K2), ssim(I, K3), ssim(I, K5)];
re2 = [psnr(I, J), psnr(I, K1), psnr(I, K2), psnr(I, K3), psnr(I, K5)];

subplot(234)
imshow(J)
title('(d) noisy image')


subplot(232)
imshow(K1)
title('(b) median')

subplot(233)
imshow(K2)
title('(c) wavelet')

subplot(235)
imshow(K3)
title('(e) PDE')

%{
subplot(235)
K4 = smartdenoise(J, gauss, salt, speckle);
imshow(K4)
title('smart denoise')
%}

addpath('learn_cross/')
subplot(236)
imshow(K5)
title('(f) new method denoising')

subplot(231)
imshow(I)
title('(a) origin image')

end