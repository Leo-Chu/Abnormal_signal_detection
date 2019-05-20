close all; clear all; clc

load('C:\Users\LeoChu\Desktop\real data tests\hangzhou3') 
test_data = ALL3170668980;  % ALL677489082; ALL410358797;    ALL3170668980; ALL3448841277;

dm = test_data(2:end,2:end); 
data1 = dm(:,:); 
[k l] = size(data1); snr = .1;
data1 = data1 + snr*randn(k,l);
[data, stdd] = mapstd(data1,0,1);

window_size = 34;
slide_size = 1;
i = 1;


while((i-1)*slide_size+window_size<l)

    a = data(:,(i-1)*slide_size+1:(i-1)*slide_size+window_size); 
    a(isnan(a))=0;
    a = a - mean(a,2)*ones(1,size(a,2)); 
    [Y1, Y2, Y3, Y4, Y5] = Calculating(a);
    T1 = Y1 - Y3;  T2 = Y2 - 2*Y4 + Y5;
    Un(i) = -1 + k*T2/T1;
    i = i + 1;
end
amax = max(Un); 

indicator = find(amax==Un);
% ALL677489082;  971~971+34
% ALL410358797;  203~203+34
% ALL3170668980; 873~873+34
% ALL3448841277; 492~492+34 


plot(1:length(Un),Un,'-ro')

%% 结果说明

%  indicator~indcator+window_size


