I = imread('womanhat.bmp');
re = [];
parms = [];
for i = 0.005:0.005:0.1
	J = imnoise(I, 'gauss', 0, i);
	parms = [parms;getparm(J)];
	re = [re;1];
end

for i = 0.005:0.005:0.1
	J = imnoise(I, 'salt & pepper', i);
	parms = [parms;getparm(J)];
	re = [re;2];
end

for i = 0.01:0.01:0.5
	J = imnoise(I, 'speckle', i);
	parms = [parms;getparm(J)];
	re = [re;3];
end

[p, a] = predict(parms);
length(a)
sum(re==a)/length(a)