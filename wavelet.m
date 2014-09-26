function rm = wavelet(im, N)
[x, y, z] = size(im);
if ~exist('N')
	N = 2;
end
if z == 1
	[thr,sorh,keepapp]=ddencmp('den','wv',im); 
	 % 自动生成小波去躁或压缩的阈值选择方案，也就是寻找默认值 
	 % [THR,SORH,KEEPAPP] = DDENCMP(IN1,'wv',X) returns default values 
	 % for de-noising(if IN1 = 'den') or compression (if IN1 = 'cmp') of X. 
	 % KEEPAPP allows you to keep approximation coefficients 
	 % (KEEPAPP=0,不对近似分量进行近似处理，KEEPAPP=11，进行阈值处理) 
	[rm,cxc,lxc,perf0,perfl2]=wdencmp('gbl',im,'sym4',N,thr,sorh,keepapp); 
	 % 使用全局阈值进行图象降噪 
	 % DENCMP performs a de-noising or compression process 
	 % of a signal or an image using wavelets.xc,cxc,lxc are the 
	 % denoised wavelet and the wavelet decomposition structure of xc, 
	 % perf0,perfl2 are L^2 recovery and compression scores in 
	 % percentages(使用 L－2 范数度量的信号的恢复率或者压缩率)
elseif (z == 3)
	for i = 1:3
		[thr,sorh,keepapp]=ddencmp('den','wv',im(:,:,i));
		[rm(:,:,i),cxc,lxc,perf0,perfl2]=wdencmp('gbl',im(:,:,i),'sym4',N,thr,sorh,keepapp); 
	end
end
rm = uint8(rm);