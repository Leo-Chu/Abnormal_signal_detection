% close all; clear all; clc
% 
% p = 10; n = 10; sigma = 1; kk = 3;
% a = normrnd(0,sigma,p,n) + kk*ones(p,n);
% Z = a'*a;
% Y1 = 0; Y3 = Y1; Y4 = Y1; Y5 = Y1; Y6 = 0; Y22 = Y1; 
function [Y11, Y22, Y33, Y44, Y55] = Calculating(a)
    Z = a'*a; [p,n] = size(Z);
    Y22 = 0; Y44 = 0;Y55 = 0; 
   
    Y11 = trace(Z)/n;
    
    for i = 1:n-1
        for j = i+1:n
            Y22 = Z(i,j)^2 + Y22;
        end
    end
    Y22 = 2*Y22/(n*(n-1));
%     Y22 = sum(sum(Z*Z'))/n;
    Y33 = (sum(sum(Z))-trace(Z))/(n*(n-1));

    for i = n:-1:3
        for j = i-1:-1:2
            for k = j-1:-1:1
                Y44 = Z(i,j)*Z(j,k) + Y44;
            end
        end
    end
    Y44 = 6*Y44/(n*(n-1)*(n-2));

    for i = n:-1:4
        for j = (i-1):-1:3
            for k = (j-1):-1:2
                for h = (k-1):-1:1
                    Y55 = Z(j,i)*Z(h,k) + Y55;                    
                end
            end
        end
    end
    Y55 = 24*Y55/(n*(n-1)*(n-2)*(n-3));
%     T1 = Y11 - Y33;  T2 = Y22 - 2*Y44 + Y55;
%     Un = 1 - T1/T2/p;
end