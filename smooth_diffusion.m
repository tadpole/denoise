function It=smooth_diffusion(I,edgestop,method,show,niter,K,yz,Io,dt)
% Catte's Selective Smoothing Diffusionȥ�뺯��
% by Qulei @2005/12/12
% I:input gray or color image
% edgestop:(edge stop function)-�Ѱ�����һ��(��pm1Ϊ��׼ͳһ)
%       ='lin':linear diffusion,    g=1
%       ='pm1':perona_malik,        g=1/(1+(x/K)^2)
%       ='pm2':perona-malik,        g=exp(-(x/K)^2)
%       ='tky':Tukey's biweight,    g= / (1-(x/K).^2).^2 ,|x|<=K
%                                      \  0              ,otherwise
% method='dir':direct-Anisotropic Diffusion,    ut=div(g(|Du|)*Du)
%       ='cat':Catte-Selective Diffusion,       ut=div(g(|G**Du|)*Du)   **��ʾ���
% show:�Ƿ���ʾ��ɢ����
%       ='ns':no show-default
%       ='is':show
% niter:number of iterations-default 100
% K:(edge threshold parameter)
% Io;noise free image(if presented:used to compute SNR)
% dt:time increment-default 0.2
I = double(I);
if ~exist('show') show='ns'; end
if ~exist('niter') niter=100; end
if ~exist('K') K=15; end
if ~exist('Io') Io=I; end
if ~exist('dt') dt=0.2; end
if (nargin<3) error('not enough arguments (at least 3 should be given)'); end

[row,col,nchannel]=size(I);

%�����һ��g()�Ĳ���k,a(��PM1Ϊ��׼ͳһ)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if edgestop=='lin'
    k=1;
elseif edgestop=='pm1'
    k=K;%�ݶ���ֵ��һ��
    a=1;%��ֵ��һ��
elseif edgestop=='pm2'
    k=K*(2^0.5);
    a=1/(2*exp(-0.5));
elseif edgestop=='tky'
    k=K*5^0.5;
    a=25/32;
end

%��ɢ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(show=='is') figure; end
for i=1:niter
    %����(N,S,E,W)�ķ�����ݶ�
    %    N
    % W  O  E 
    %    S
    Gn=[I(1,:,:);I(1:row-1,:,:)]-I;  %N-O
    Gs=[I(2:row,:,:);I(row,:,:)]-I;  %S-O
    Ge=[I(:,2:col,:) I(:,col,:)]-I;  %E-O
    Gw=[I(:,1,:) I(:,1:col-1,:)]-I;  %W-O
    
    if method=='cat'%Selective Diffusion
        I_bak=I;
        H=fspecial('gaussian',3,0.5);
        I=convn(I,H,'same');
        %guassianƽ������ķ����ݶ�
        Gsn=[I(1,:,:);I(1:row-1,:,:)]-I;  %N-O
        Gss=[I(2:row,:,:);I(row,:,:)]-I;  %S-O
        Gse=[I(:,2:col,:) I(:,col,:)]-I;  %E-O
        Gsw=[I(:,1,:) I(:,1:col-1,:)]-I;  %W-O
        %G=G_bak;G<=Gs
        Gn_bak=Gn;Gs_bak=Gs;Ge_bak=Ge;Gw_bak=Gw;
        Gn=Gsn;Gs=Gss;Ge=Gse;Gw=Gsw;
    end
    
    %���ղ�ͬ����ɢ����(�ѹ�һ��)������������ɢϵ��
    if edgestop=='lin'%����ͬ����ɢ(gaussian)
        Cn=k;Cs=k;Ce=k;Cw=k;
    elseif edgestop=='pm1'%����������ɢ(PM1)-Ч�����(K=5)
        Cn=1./(1+(Gn/k).^2).*a;
        Cs=1./(1+(Gs/k).^2).*a;
        Ce=1./(1+(Ge/k).^2).*a;
        Cw=1./(1+(Gw/k).^2).*a;
    elseif edgestop=='pm2'%����������ɢ(PM2)
        Cn=exp(-(Gn/K).^2).*a;
        Cs=exp(-(Gs/k).^2).*a;
        Ce=exp(-(Ge/k).^2).*a;
        Cw=exp(-(Gw/k).^2).*a;
    elseif edgestop=='tky'%����������ɢ(Tukey)
        Cn=zeros(row,col,nchannel);Cs=Cn;Ce=Cn;Cw=Cn;
        indexn=find(abs(Gn)<=k);
        indexs=find(abs(Gs)<=k);
        indexe=find(abs(Ge)<=k);
        indexw=find(abs(Gw)<=k);
        Cn(indexn)=(1-(Gn(indexn)/k).^2).^2*a;
        Cs(indexs)=(1-(Gs(indexs)/k).^2).^2*a;
        Ce(indexe)=(1-(Ge(indexe)/k).^2).^2*a;
        Cw(indexw)=(1-(Gw(indexw)/k).^2).^2*a;
    end
    
    if method=='cat'%Selective Diffusion
        %G<=G_bak;
        Gn=Gn_bak;Gs=Gs_bak;Ge=Ge_bak;Gw=Gw_bak;
        I=I_bak;
    end
    
	I_old = I;
    %�ݶ��½����������PDE(��ɢ)
    I=I+dt*(Cn.*Gn+Cs.*Gs+Ce.*Ge+Cw.*Gw);
	mean(mean(mean(abs(I - I_old))));
    if (mean(mean(mean(abs(I - I_old)))) < yz)
		break
	end
	
    if(show=='is')
        imshow(uint8(I));
    end
%     pause;
    
%     %����ͼ��
%     step=1;
%     if rem(i-1,step)==0
% %         imwrite(uint8(I),[num2str(round((i-1)/step)),'.bmp'],'bmp');
%         saveas(gcf,[num2str(round((i-1)/step)),'.jpg']);
%     end
    
end
It=uint8(I);