clear all
clc

[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
I = imread([pathname,filename]);    
% Resize image for easier computation
B = imresize(I, [584 565]);
% Read image
im = im2double(B);
% Convert RGB to Gray via PCA
lab = rgb2lab(im);
f = 0;
wlab = reshape(bsxfun(@times,cat(3,1-f,f/2,f/2),lab),[],3);
[C,S] = pca(wlab);
S = reshape(S,size(lab));
S = S(:,:,1);
gray = (S-min(S(:)))./(max(S(:))-min(S(:)));
%% Contrast Enhancment of gray image using CLAHE
J = adapthisteq(gray,'numTiles',[8 8],'nBins',128);
%% Background Exclusion
% Apply Average Filter
h = fspecial('average', [9 9]);
JF = imfilter(J, h);
figure, imshow(JF)
% Take the difference between the gray image and Average Filter
Z = imsubtract(JF, J);
figure, imshow(Z)
%% Threshold using the IsoData Method
level=isodata(Z); % this is our threshold level
%% Convert to Binary
BW = im2bw(Z, level-.008);
%% Remove small pixels
BW2 = bwareaopen(BW, 100);
%% Overlay
BW2 = imcomplement(BW2);
out = imoverlay(B, BW2, [0 0 0]);
figure, imshow(out)
I=I(:,:,2);
I=imresize(I,[200 200]);
L=double(I);
% lapale
sp=fspecial('laplacian');
M=imfilter(I,sp);
% to find average gradient Q
Q=mean(mean(M));
t=191.25;
T=M>t;
BW = bwareaopen(T,2);
N=BW;
[m n]=size(N);
ed=[];
tex=[];
p=0;
q=0;
for i=1:m
 for   j=1:n
     if N(i,j)==0
         p=p+1;
         tex(p)=I(i,j);
     else
         q=q+1;
         ed(q)=M(i,j);
     end
 end
end
Med=mean(ed(:));
Mtex=mean(tex(:));
v1=(Med-Q)/Med;
v2=(Q-Mtex)/Q;
% to find v
v = order7(M,t,v1,v2);
%convolve with the mask
S=padarray(L,[2,2]);
[m n]=size(S);
J=zeros(size(S));
for i1=1:m-4
    for j1=1:n-4
        F2= [ v(i1,j1)/(8*(v(i1,j1)-2)) 0  v(i1,j1)/(8*(v(i1,j1)-2)) 0  v(i1,j1)/(8*(v(i1,j1)-2));
            0 -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) 0;
            v(i1,j1)/(8*(v(i1,j1)-2)) -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) 8/(8-12*v(i1,j1)+4*v(i1,j1)^2) -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) v(i1,j1)/(8*(v(i1,j1)-2));
            0 -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) -(v(i1,j1)/(4*(v(i1,j1)^2-3*v(i1,j1)+2))) 0;
            v(i1,j1)/(8*(v(i1,j1)-2)) 0 v(i1,j1)/(8*(v(i1,j1)-2)) 0 v(i1,j1)/(8*(v(i1,j1)-2))]; 
        J(i1,j1)=sum(sum((F2).*S(i1:i1+4,j1:j1+4)));
    end
end

%% prepro
g=fspecial('gaussian');
pre=imfilter(double(J),g);

% thresholding
gr=uint8(pre);
th=graythresh(gr);
be=gr>140;
figure,imshow(be)

gchanel=uint8(pre);                         %Green Chanel Extraction
Igchanel = imcomplement(gchanel);             %Inversion
conenhance = adapthisteq(Igchanel);           %Contrast Enhancement
gg=fspecial('gaussian',2);
g = imfilter(conenhance,gg);                %Gaussian filtering
se = strel('ball',8,8);
tophat = imtophat(g,se);                       %Tophat transform
med = medfilt2(tophat);                        %Median filtering
background = imopen(med,strel('disk',15));
I2 = med - background;                         % Background Removal
I3 = imadjust(I2);                             % Intensity Adjustment

level = graythresh(gchanel);                  % Gray Threshold
bw =  imbinarize(I3,level);

se = strel('disk',2);
di = imdilate(bw,se);

se = strel('disk',4);
er = imerode(di,se);

post = bwareaopen(bw,8);
re = imresize(bw,[200 200]);
outt = immultiply(I,imcomplement(re));

% FEATURES
vessel = outt;
I2 = vessel;
m = size(I2,1);
n = size(I2,2);
for di=2:m-1
    for dj=2:n-1
        J10=I2(di,dj);
        I3(di-1,dj-1)=I2(di-1,dj-1)>J10;
        I3(di-1,dj)=I2(di-1,dj)>J10;
        I3(di-1,dj+1)=I2(di-1,dj+1)>J10; 
        I3(di,dj+1)=I2(di,dj+1)>J10;
        I3(di+1,dj+1)=I2(di+1,dj+1)>J10; 
        I3(di+1,dj)=I2(di+1,dj)>J10; 
        I3(di+1,dj-1)=I2(di+1,dj-1)>J10; 
        I3(di,dj-1)=I2(di,dj-1)>J10;
        LBP(di,dj)=I3(di-1,dj-1)*2^7+I3(di-1,dj)*2^6+I3(di-1,dj+1)*2^5+I3(di,dj+1)*2^4+I3(di+1,dj+1)*2^3+I3(di+1,dj)*2^2+I3(di+1,dj-1)*2^1+I3(di,dj-1)*2^0;
    end
end