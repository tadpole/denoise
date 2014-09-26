addpath('../');
J = imread('../frame00002.jpg');

K = 15;
iter = 100;

K1 = med(J);
K2 = wavelet(J);
K3 = smooth_diffusion(J,'pm1','cat','ns',iter,K, 0.3);
s = predict(getparm(J));
K5 = smartdenoise(J, s(1), s(2), s(3));

subplot(321)
imshow(J)
title('(a) noisy image')


subplot(322)
imshow(K1)
title('(b) median')

subplot(323)
imshow(K2)
title('(c) wavelet')

subplot(324)
imshow(K3)
title('(d) PDE')

%{
subplot(235)
K4 = smartdenoise(J, gauss, salt, speckle);
imshow(K4)
title('smart denoise')
%}

subplot(325)
imshow(K5)
title('(e) new method denoising')