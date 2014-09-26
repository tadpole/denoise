function v = predict2(im, a, b, c)
	J = im;
	J = imnoise(J, 'gauss', 0, a);
	J = imnoise(J, 'salt & pepper', b);
	J = imnoise(J, 'speckle', c);
	v = predict(getparm(J));
end