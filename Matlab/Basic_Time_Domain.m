clc;
clear all;
close all;
[data,fs]= audioread('/Users/milaprane/Documents/Milap/Fall 2015/Assignment 3-Comp Music/400.au');
plot(data);
%%%%%%%%%%%%%%%%%%%%%%%%%%CONVERTING THE MESSAGE INTO BITS%%%%%%%%%%%%%%%%%%%%%
message = ('What is easy, remember what happened to a boy who was good, and kind, and brave, because he strayed across the path of Lord Voldemort. Remember Cedric Diggory.');
unimessage= unicode2native(message,'US-Ascii');
unimessagemod= str2num(dec2bin(unimessage));
unimessagestream = [];
unimessagestream = dec2bin(message,8)';
unimessagestream = unimessagestream(:)'-'0';
unimessagestreamcheck=BitstoNBitIntegers(unimessagestream, 8);
unimessagestreamcheckchar=char(unimessagestreamcheck);


lsbit=16;
mbit=1;
intdata=(data(:,1) * 32768);

intdatainstream=dec2bin(typecast(abs(intdata),'uint16'));

intdata2=typecast(intdata,'int16');
embedbit=[];
comp = [];
%%%%%%%%%%%%%EMBEDDING MESSAGE%%%%%%%%%%%%%%%%%%%%%%%%%
% for count=1:length(unimessagestream)
%     intdata(count,1) = bitset(int16(intdata(count,1)),mbit,int16(unimessagestream(count)));
%     intdata3(count,1) = bitset((intdata2(count,1)),lsbit,int16(unimessagestream(count)));
%     comp = [comp; intdata2(count,1) intdata3(count,1)]
% end
intdata4=[double(bitset(int16(intdata(1:length(unimessagestream))'),mbit,int16(unimessagestream(1:end)))) double(intdata((length(unimessagestream)+1):end)')];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data2=double(intdata4/ (32768));
intdataoutstream=dec2bin(typecast(abs(intdata),'uint16'));
data3= typecast(intdata2/32768,'double');
messagestream = bitget(int16(intdata4),1);
messagestream = messagestream(1:length(unimessagestream));
messagebytes=BitstoNBitIntegers(messagestream, 8);
message= native2unicode(messagebytes);


audiowrite('NewAudioWrittenTime.wav',data2,fs);

