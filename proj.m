%Source: https://shannonmountainman.files.wordpress.com/2011/09/sunrise-if-garden-of-gods.jpg
imgNat = imread('sunrise-if-garden-of-gods.jpg'); 

imgNat = im2double(imgNat); %figure(1); imshow(imgNat);
imgNat_g = rgb2gray(imgNat);  %converting to grayscale to take 2D FFT
NatF = fft2(imgNat_g); %take the fft2 of the grayscale to find spectrum
F2 = fftshift(NatF,2); %figure(1); plot(abs(NatF)); 
sumF = sum(sum(abs(NatF))); %Total magnitude of the FT

N_R = imgNat(:,:,1); N_G = imgNat(:,:,2); N_B = imgNat(:,:,3);

%We are downsampling each of the RGB spectrum by factor of 3
d_imgN1 = downsample(N_R,3); d_imgN1 = downsample(d_imgN1',3);
d_imgN2 = downsample(N_G,3); d_imgN2 = downsample(d_imgN2',3);
d_imgN3 = downsample(N_B,3); d_imgN3 = downsample(d_imgN3',3);
d_imgN1 = d_imgN1'; d_imgN2 = d_imgN2'; d_imgN3 = d_imgN3';

%Concatanate to combine 3 spectrum
newImg = cat(3,d_imgN1,d_imgN2,d_imgN3); %imwrite(newImg, 'test.tif')
%info = imfinfo('test.tif'); figure(2); imshow(newImg);

%----- filter creation: referenced from hw 4 (Zero-phase)
%: https://ccrma.stanford.edu/~jos/fp/Example_Zero_Phase_Filter_Design.html
df = [0 ((0.5)-0.05) ((0.5)+0.05) 1]; da = [1.0 1.0 0.0 0.0];
db = firpm(31,df,da,'equiripple'); %using equiripple FIR
[dh dw] = freqz(db,1,512); figure(1); plot(dw/pi,dh); grid on;














