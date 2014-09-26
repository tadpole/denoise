I = imread('womanhat.bmp');
J = I;
J = imnoise(J, 'gauss', 0, 0.01);
J = imnoise(J,'salt & pepper', 0.04);
J = imnoise(J, 'speckle', 0.05);
[p,a] = predict(getparm(J))