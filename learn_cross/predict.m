function v = predict(parm)
	fid = fopen('test_ind.txt','w');
	for i = 1:size(parm, 1)
		fprintf(fid,'%d ',2);
		for k = 1:size(parm, 2)
			fprintf(fid,'%d:%f ',k,parm(i, k));
		end
		fprintf(fid,'\n');
	end
	fclose(fid);
	
	system(['..\svm-scale -r range_gauss test_ind.txt > test_ind_scaled']);
	system(['..\svm-predict -b 1 test_ind_scaled train_gauss_scale.model gauss_output > temp.txt']);
	delete test_ind_scaled temp.txt
	
	system(['..\svm-scale -r range_salt test_ind.txt > test_ind_scaled']);
	system(['..\svm-predict -b 1 test_ind_scaled train_salt_scale.model salt_output > temp.txt']);
	delete test_ind_scaled temp.txt
	
	system(['..\svm-scale -r range_speckle test_ind.txt > test_ind_scaled']);
	system(['..\svm-predict -b 1 test_ind_scaled train_speckle_scale.model speckle_output > temp.txt']);
	delete test_ind_scaled temp.txt
	
	fid = fopen('gauss_output','r');
	C = textscan(fid,'%f');
	t1 = [C{1}];
	fclose(fid);
	
	fid = fopen('salt_output','r');
	C = textscan(fid,'%f');
	t2 = [C{1}];
	fclose(fid);
	
	fid = fopen('speckle_output','r');
	C = textscan(fid,'%f');
	t3 = [C{1}];
	fclose(fid);
	delete test_ind.txt gauss_output salt_output speckle_output
	v = [t1+0.075 t2 t3+0.075]; %fixed
end