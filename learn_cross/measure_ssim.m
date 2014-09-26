I = imread('womanhat.bmp');
J = I;
index = zeros(1, 5);
time = 10;
K = 15;
iter = 20;
h = waitbar(0,'testing¡­¡­');
set(h,'Name','test');
for t = 1:time
	gauss = rand(1)*0.1;
	speckle = rand(1)*1;
	salt = rand(1)*0.5;
	J = I;
	J = imnoise(J, 'speckle', speckle);
	J = imnoise(J, 'salt & pepper', salt);
	J = imnoise(J, 'gaussian', 0, gauss);
	K1 = med(J);
	K2 = wavelet(J);
	K3 = smooth_diffusion(J,'pm1','cat','ns',iter,K, 0.3);
	K4 = smartdenoise(J, gauss, salt, speckle);
	[gauss, speckle, salt]
	temp = [ssim(I,J), ssim(I,K1), ssim(I, K2), ssim(I, K3), ssim(I, K4)]
	index = index+temp;
	waitbar(t/time);
end
close(h);
index/time
% 0.2484    0.4175    0.3688    0.5776    0.5841