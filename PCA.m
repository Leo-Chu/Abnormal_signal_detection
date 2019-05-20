function [out,kk] = PCA(X, tau, k0)
    [m,n] = size(X);
    Z = (X- mean(X,2)*ones(1,n)); %  - mean(X,2)*ones(1,n) 
    C_train = Z*Z'/(n); % covariance matrix
    [V D] = eig(C_train); % V are eigenvectors and D are eigenvalues
    if D(1,1)>D(2,2)
        flag = 1; % 特征值降序排列
    else
        flag = 0; % 特征值升序排列
    end
%     diag(D)
%     max(diag(D))
%     min(diag(D))
    if nargin == 2
        for ii = 1:m    
            if D(ii,ii)>tau
                kk = ii;
                break;
            end
        end 
        if flag == 1
            P = V(1:kk,:);
            X_hat = P*X; %size(X_hat)
            out = orth(X_hat')';  
        else
            P = V(kk:end,:); 
            X_hat = P*X;  %size(X_hat)  
            out = orth(X_hat')'; 
        end
        
    else
        kk = k0;
        if flag == 1
            P = V(1:kk,:);
            X_hat = P*X; %size(X_hat)
            out = orth(X_hat')'; 
        else
            P = V(kk:end,:);
            X_hat = P*X;  %size(X_hat)  
            out = orth(X_hat')'; 
        end     
    end
    
end