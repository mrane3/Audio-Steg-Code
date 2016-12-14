clc;
clear all;
[data,fs]= audioread('NewAudioWrittenTime.wav');
lsbit=16;
mbit=1;
messagestreamlength=[];
intdata= 32768 * data;
for count=1:64
    messagestreamlength=[messagestreamlength bitget(int16(intdata(count,1)),1)];
end
messagestreamlength=BitstoNBitIntegers(messagestreamlength, 64);

messagestream=bitget(int16(intdata(65:messagestreamlength+64)),1);
%%%%%%%%%%%%%%Parsing to make sense as message%%%%%%%%%%
%messagestream=flip(messagestream);
messagebytes=BitstoNBitIntegers(messagestream, 8);
ascmessage=char(messagebytes)';
