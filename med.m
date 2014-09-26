function rm = med(im)
[x, y, z] = size(im);
if z == 1
	rm = medfilt2(im, [5 5]);
elseif z == 3
	for i = 1:3
		rm(:,:,i)= medfilt2(im(:,:,i), [5 5]);
	end
end
end