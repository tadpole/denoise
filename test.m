clear;
I = imread('cameraman.tif');
% I = imread('womanhat.bmp');
subplot(231)
imshow(I);
title('orgin')
J = imnoise(I,'gaussian',0, 0.005);
J = imnoise(J,'salt & pepper',0.1); 
% J = imnoise(I,'speckle',0.01); 
subplot(232)
imshow(J);
title('noise')
K1 = med(J);
subplot(233)
imshow(K1)
title('med')
K2 = wavelet(J);
subplot(234)
imshow(K2)
title('wavelet')
K = 15;
iter = 10;
K3 = smooth_diffusion(J,'pm1','cat','ns',iter,K);
subplot(235)
imshow(K3)
title('pde')
K4 = totalvariation(J, iter);
subplot(236)
imshow(K4)
title('tv')