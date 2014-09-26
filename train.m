path_ref = 'refimgs';
path_gauss = 'gauss';
path_salt = 'salt';
path_speckle = 'speckle';


allparm = [];
fid = fopen('denoise_train','w');

allfile = dir(['db/' path_gauss '/*.bmp']);
names_gauss = {allfile.name};
for k = 1:length(names_gauss)
	im = imread(['db/' path_gauss '/' cell2mat(names_gauss(k))]);
	parm = getparm(im);
	allparm = [allparm;parm];
end

allfile = dir(['db/' path_salt '/*.bmp']);
names_salt = {allfile.name};
for k = 1:length(names_salt)
	im = imread(['db/' path_salt '/' cell2mat(names_salt(k))]);
	parm = getparm(im);
	allparm = [allparm;parm];
end

allfile = dir(['db/' path_speckle '/*.bmp']);
names_speckle = {allfile.name};
for k = 1:length(names_speckle)
	im = imread(['db/' path_speckle '/' cell2mat(names_speckle(k))]);
	parm = getparm(im);
	allparm = [allparm;parm];
end
s = length(names_gauss)*3;
ll = randsample(1:s,s);

for i = 1:s
	j = ll(i);
	k = floor((j-1)/length(names_gauss));
	fprintf(fid,'%d ',k);
	parm = allparm(j,:);
	for t = 1:length(parm)
		fprintf(fid,'%d:%f ',t,parm(t));
	end
	fprintf(fid,'\n');
end
fclose(fid);

system(['svm-scale -s denoise_range denoise_train > train_scale']);
system(['svm-train -b 1 train_scale denoise_model > temp.txt']);
delete temp.txt