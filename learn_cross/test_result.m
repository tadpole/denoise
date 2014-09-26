clear
I = imread('peppers.png');

h = waitbar(0,'testing¡­¡­');
set(h,'Name','test');

r = [0.5 0.7 0.4;0.3 0.3 0.5];
res = [];
res2 = [];
for i = 1:size(r,1)
	index = r(i, :);
	[re, re2] = test_2(I, index(1), index(2), index(3));
	res = [res;re];
	res2 = [res2; re2];
	waitbar(i/size(r,1))
end
res
res2
close(h);