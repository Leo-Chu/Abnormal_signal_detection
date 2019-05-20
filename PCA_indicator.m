close all; clear all; clc

load('C:\Users\LeoChu\Desktop\real data tests\hangzhou3') % pv11810000noise
test_data = ALL3170668980;  % ALL677489082; ALL410358797;    ALL3170668980; ALL3448841277;

dm = test_data(2:end,2:end); 

data1 = dm(:,:); 
[k l] = size(data1); snr = .1;
data1 = data1 + snr*randn(k,l);
[data, stdd] = mapstd(data1,0,1);

window_size = round(1.2*k);
slide_size = 1;
tau0 = 10^(-1);
ii = 1;


while(ii*slide_size+window_size<=l) % i*slide_size+window_size<l

    a = data(:,(ii-1)*slide_size+1:(ii-1)*slide_size+window_size); 
    a(isnan(a))=0;
    b = data(:,ii*slide_size+1:ii*slide_size+window_size); 
    b(isnan(b))=0;
    [Y1, m1] = PCA(a, tau0); % 
    [Y2, ~] = PCA(b, tau0, m1); % 
   
    for i = 1:k-m1+1
        v1 = inv(Y1*Y1')*Y1*a(m1+i-1,:)';
        y1_hat = Y2'*v1;
        y1 = y1_hat' - a(m1+i-1,:);
        e_normal(i) = y1/a(m1+i-1,:);
        y2_hat = Y1'*v1;
        y2 = y2_hat' - a(m1+i-1,:);
        e(i) = y2/a(m1+i-1,:);
        eta(i) = e(i)/e_normal(i);
    end
    index(ii) = max(eta);
    ii = ii + 1;
end
imax = max(index); 
indicator = find(imax==index);
plot(1:length(index),index,'-ro')

%% Result หตร๗
%  indicator~indcator+window_size

