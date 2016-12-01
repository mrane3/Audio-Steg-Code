clc;
clear all;
[data,fs]= audioread('/Users/milaprane/Documents/Milap/Fall 2015/Assignment 3-Comp Music/1.au');
spectrogram(data,hamming(1024).^2,512,1024,'yaxis',fs);
lpFilt = designfilt('lowpassfir','PassbandFrequency',0.55, ...
         'StopbandFrequency',0.65,'PassbandRipple',0.5, ...
         'StopbandAttenuation',100,'DesignMethod','kaiserwin');
fvtool(lpFilt)
dataOut = filter(lpFilt,data);
figure(4);
spectrogram(dataOut,hamming(1024),512,1024,'yaxis',fs);
[s,f,t]=spectrogram(dataOut,hamming(1024),512,1024,'yaxis',fs);
angle(s);
I=image(real(s));
imwrite(real(s),'imagebefore.png');

Inew=imread('imagebefore.png');
position = [500 32]; 
box_color = {'black'};
RGB = insertText(Inew,position,'Hi All!!! Whats up??','FontSize',40,'BoxColor',...
    box_color,'BoxOpacity',0.4,'TextColor','white');
imshow(RGB);
imwrite(Inew,'embeddedsignal.png');
signal = imagetosignal('embeddedsignal.png', 'png');
signal=signal(1:floor(length(signal)/2))/max(signal);
newspec=spectrogram(signal,hamming(1024).^2,512,1024,'yaxis',fs);



