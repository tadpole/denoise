path_ref = 'refimgs';
path_res = 'result';

size_ref = 10;
n = 8;

total_pic = n^3*size_ref;
link_sample = randsample(1:total_pic, total_pic);
link = [];
q_gauss = linspace(0, 0.5, n);
q_salt = linspace(0, 0.1, n);
q_speckle = linspace(0, 0.5, n);

num = 1;
h = waitbar(0,'building database¡­¡­');
set(h,'Name','img database');
for ref_num = 1:size_ref
	img_path = [path_ref '/ref' num2str(ref_num) '.bmp'];
	im = imread(img_path);
	for speckle = q_speckle
		im1 = imnoise(im, 'speckle', speckle);
		for salt = q_salt
			im2 = imnoise(im1, 'salt & pepper', salt);
			for gauss = q_gauss
				waitbar(num/total_pic);
				im3 = imnoise(im2, 'gauss', 0, gauss);
				name = [path_res '/res' num2str(link_sample(num)) '.bmp'];
				imwrite(im3, name);
				link(link_sample(num), :) = [gauss, salt, speckle, ref_num];
				num = num+1;
			end
		end
	end
end
save model link
close(h);