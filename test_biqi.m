addpath('D:\study\study_star\10_5_NR_BIQI_release')
I = imread('womanhat.bmp');
x = 0:0.005:0.1;
y = []
for k = x
	%J = imnoise(I, 'gaussian', 0, k);
	J = imnoise(I, 'salt & pepper', k);
	%J = imnoise(I, 'speckle', k);
	temp = biqi(J)
	y = [y, temp];
end
plot(x, y)