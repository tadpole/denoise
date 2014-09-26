path_ref = '../db_cross/refimgs';
path_res = '../db_cross/result';
addpath('../')

load ../db_cross/model.mat
allfile = dir([path_res '/*.bmp']);
names_file = {allfile.name};
size_pic = length(names_file);

link_gauss = link(:, 1);
link_salt = link(:, 2);
link_speckle = link(:, 3);
fid1 = fopen('gauss_re_train','w');
fid2 = fopen('salt_re_train','w');
fid3 = fopen('speckle_re_train','w');
h = waitbar(0,'training¡­¡­');
set(h,'Name','train');
for k = 1:size_pic
	im = imread([path_res '/res' num2str(k) '.bmp']);
	parm = getparm(im);
	fprintf(fid1,'%f ',link_gauss(k));
	fprintf(fid2,'%f ',link_salt(k));
	fprintf(fid3,'%f ',link_speckle(k));
	for t = 1:length(parm)
		fprintf(fid1,'%d:%f ',t,parm(t));
		fprintf(fid2,'%d:%f ',t,parm(t));
		fprintf(fid3,'%d:%f ',t,parm(t));
	end
	fprintf(fid1,'\n');
	fprintf(fid2,'\n');
	fprintf(fid3,'\n');
	waitbar(k/size_pic);
end
fclose(fid1);
fclose(fid2);
fclose(fid3);

close(h);

system(['..\svm-scale -s range_gauss gauss_re_train > train_gauss_scale']);
system(['..\svm-train -b 1 -s 4 -q train_gauss_scale']);

system(['..\svm-scale -s range_salt salt_re_train > train_salt_scale']);
system(['..\svm-train -b 1 -s 4 -q train_salt_scale']);

system(['..\svm-scale -s range_speckle speckle_re_train > train_speckle_scale']);
system(['..\svm-train -b 1 -s 4 -q train_speckle_scale']);