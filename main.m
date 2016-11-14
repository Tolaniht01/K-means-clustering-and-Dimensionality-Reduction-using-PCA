function main
M = dlmread('data.txt',',');
 K_means(M,10);
 K_means(M,15);
 K_means(M,5);


Avg=mean(M);
%size(Avg)
R=vec2mat(Avg,20);
imwrite(R','mean.png');
%R=vec2mat(M(4100,:),20);
%imwrite(R','eight.png');
[m,n]=size(M);
N=zeros(m,n);

for i=1:m
    for j=1:n
        N(i,j)=M(i,j)-Avg(1,j);
    end
end

% using the 2 norm for calculating the distance %
% sum_norm=0;
% for i=1:m
%     sum_norm=sum_norm+norm(M(i,:));
% end
%sum_norm
co=N'*N;
size(co);
%co(1,1)
[U S V]=svd(co);
[a b]=size(U);
Z=[];
for i=1:b
    Z=[Z,U(:,i)];
    %size(Z)
    %size(M')
    Y=Z'*M';
    Y=Y'*Z';
    %Y(1,1)
    %size(Y)
    [error]=check_error(M,Y);
    %error
    if(error/5000<0.1)
        
            numb_vec=i;
            break;
    end
end

disp('Number of Principal Components');
numb_vec
error
[s t]=size(Y);
% adding the average value for the feature to reconstructed data %
for i=1:s
    for j=1:t
        Y(i,j)=Avg(1,j)+Y(i,j);
    end
end
%R=vec2mat(Y(4100,:),20);
% imwrite(R','eight_K=new_const.png');
% Y is the reconstructed data set in the new space %
K_means(Y,10);
K_means(Y,15);
K_means(Y,5);
end

function [error]=check_error(M,Y)
    [x y]=size(Y);
    for i=1:x
        for j=1:y
            M(i,j)=M(i,j)-Y(i,j);
        end
    end
    error=0;
    for i=1:x
        error=error+norm(M(i,:))^2;
    end
    
    return;
end

