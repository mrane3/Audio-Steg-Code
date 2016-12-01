clc;
clear all;
[data,fs]= audioread('NewAudioWrittenTime.wav');
lsbit=16;
mbit=1;
messagestream=[];
intdata= 32768 * data;
% for count=1:40
%     messagestream=[messagestream bitget(int16(intdata(count,1)),1)];
% end

messagestream=bitget(int16(intdata(1:(250*8))),1);
%%%%%%%%%%%%%%Parsing to make sense as message%%%%%%%%%%
%messagestream=flip(messagestream);
messagebytes=BitstoNBitIntegers(messagestream, 8);
ascmessage=char(messagebytes)';