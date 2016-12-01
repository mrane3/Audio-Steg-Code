
clc;
clear all;
[data,fs]= audioread('/Users/milaprane/Documents/Milap/Fall 2015/Assignment 3-Comp Music/1.au');
[yl zl]=buffer(data(:,1),1024);
messagetest=[];
%[yr zr]=buffer(data(:,2),1024);
lmean=mean(yl);
%rmean=mean(yr);
%%%%%%%%%%%%%%%%%%%%%%%%%%CONVERTING THE MESSAGE INTO
%%%%%%%%%%%%%%%%%%%%%%%%%%BITS%%%%%%%%%%%%%%%%%%%%%
lmeanmod=mod(lmean,2);
%rmeanmod=mod(rmean,2);
message = ('gtcmt');
unimessage= unicode2native(message,'US-Ascii');
unimessagemod= str2num(dec2bin(unimessage));
unimessagestream = [];
unimessagestream = dec2bin(message,8)';
unimessagestream = unimessagestream(:)'-'0'
unimessagestreamcheck=BitstoNBitIntegers(unimessagestream, 8);
unimessagestreamcheckchar=char(unimessagestreamcheck)
%unimessagestream=flip(unimessagestream);
%unimessagestream2=cell2mat(unimessagemod);
[rowyl colyl] = size(yl);
%[rowyr colyr] = size(yr);
lsbit=4;

mbit=1;

%%%%%%%%%%%%%EMBEDDING MESSAGE%%%%%%%%%%%%%%%%%%%%%%%%%
newdatal=[];
for count = 1:colyl
    dctframeleft(count,:) =  fft(yl(:,count));
    intdctframeleft(count,:)= 32767 * dctframeleft(count,:);
%   dctframeright(count,:)=  fft( hamming(1024).*yr(:,count));   
    [pkl locl]=findpeaks(abs(dctframeleft(count,:)),'MinPeakDistance',1024/4);
  %  [pkr locr]=findpeaks(abs(dctframeright(count,:)),'MinPeakDistance',1024/4);
     while(mbit<length(unimessagestream))
       if sum(dctframeleft(count,:))==0 
           break;
        else
        intdctframeleft(count,locl)=bitset(int64(abs(intdctframeleft(count,locl))),lsbit,unimessagestream(mbit));
        %dctframeright(count,locr)=bitset(uint64(abs(dctframeright(count,locl))),lsbit,unimessagestream(mbit));
        messagebits= bitget(int64(abs(intdctframeleft(count,locl))),lsbit);
        mbit=mbit+1;
       end
     end
    inttobackdctframeleft(count,:)=(intdctframeleft(count,:)/32768);
     refft= real(ifft(inttobackdctframeleft(count,:)));
     newdatal=[newdatal refft];
     messagetest= [message messagebits];
    
end

newdatal=newdatal/max(data);
 
audiowrite('NewAudioWritten.wav',newdatal,fs/2);










