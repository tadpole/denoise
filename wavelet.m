function rm = wavelet(im, N)
[x, y, z] = size(im);
if ~exist('N')
	N = 2;
end
if z == 1
	[thr,sorh,keepapp]=ddencmp('den','wv',im); 
	 % �Զ�����С��ȥ���ѹ������ֵѡ�񷽰���Ҳ����Ѱ��Ĭ��ֵ 
	 % [THR,SORH,KEEPAPP] = DDENCMP(IN1,'wv',X) returns default values 
	 % for de-noising(if IN1 = 'den') or compression (if IN1 = 'cmp') of X. 
	 % KEEPAPP allows you to keep approximation coefficients 
	 % (KEEPAPP=0,���Խ��Ʒ������н��ƴ���KEEPAPP=11��������ֵ����) 
	[rm,cxc,lxc,perf0,perfl2]=wdencmp('gbl',im,'sym4',N,thr,sorh,keepapp); 
	 % ʹ��ȫ����ֵ����ͼ���� 
	 % DENCMP performs a de-noising or compression process 
	 % of a signal or an image using wavelets.xc,cxc,lxc are the 
	 % denoised wavelet and the wavelet decomposition structure of xc, 
	 % perf0,perfl2 are L^2 recovery and compression scores in 
	 % percentages(ʹ�� L��2 �����������źŵĻָ��ʻ���ѹ����)
elseif (z == 3)
	for i = 1:3
		[thr,sorh,keepapp]=ddencmp('den','wv',im(:,:,i));
		[rm(:,:,i),cxc,lxc,perf0,perfl2]=wdencmp('gbl',im(:,:,i),'sym4',N,thr,sorh,keepapp); 
	end
end
rm = uint8(rm);