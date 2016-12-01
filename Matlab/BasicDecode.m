clc;
[data,fs]= audioread('NewAudioWritten.wav');
[yl zl]=buffer(data(:,1),1024);
[rowyl colyl] = size(yl);
finmessagestream=[];
%%%%%%%%%%%%%%%%%%Extracting Bits%%%%%%%%%%%
newdatal=[];
for count = 1:colyl
    dctframeleft(count,:) =  fft(yl(:,count));   
%   dctframeright(count,:)=  fft( hamming(1024).*yr(:,count));
    intdctframeleft(count,:)= 32767 * dctframeleft(count,:);
    [pkl locl]=findpeaks(abs(dctframeleft(count,:)),'MinPeakDistance',1024/4);
%     [pkr locr]=findpeaks(abs(dctframeright(count,:)),'MinPeakDistance',1024/4);    
       if sum(dctframeleft(count,:))==0 
           break;
       else
        finmessagestream= [finmessagestream bitget(int64(abs(intdctframeleft(count,locl))),15)];
       end
end

%%%%%%%%%%%%%%Parsing to make sense as message%%%%%%%%%%
finmessagebytes=BitstoNBitIntegers(finmessagestream, 8);
for count=1:length(finmessagebytes)
if (finmessagebytes(count)>=128 && finmessagebytes(count)< 255)
    finmessagebytes(count)= 255-finmessagebytes(count);
end
end
ascmessage=char(finmessagebytes);
    
            
        