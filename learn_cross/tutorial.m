addpath('../')
I = imread('../frame00002.jpg');
var = predict(getparm(I));
J = smartdenoise(I, var(1), var(2), var(2));
imshow(J)