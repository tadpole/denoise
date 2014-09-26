function rm = totalvariation(im, iter)
	[x, y, z] = size(im);
	im = double(im);
	if z == 1
		rm = tv(im, iter);
	elseif z == 3
		for i = 1:3
			rm(:,:,i) = tv(im(:,:,i), iter);
		end
	end
	rm = uint8(rm);
end