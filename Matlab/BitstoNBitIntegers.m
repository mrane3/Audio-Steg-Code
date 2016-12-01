function [ uD10 ] = BitstoNBitIntegers( A, n)


B = 1;
% get each group of bits in a column of K.
K = cell2mat(arrayfun(@(bit)bitget(A, B+1-bit), 1:B, 'UniformOutput', 0))';
%make sure there is multiple of B
K = K(:);
% while ~(mod(numel(K),n) == 0)
%     K = [0;K];
% end
K = K(:);
% reshape to have them in 8 packs
K = reshape(K, [n, numel(K)/n])';
% get the uint8 vec.
UD = (2.^(size(K,2)-1:-1:0))';
K= double(K)*(UD);
uD10=K;

end