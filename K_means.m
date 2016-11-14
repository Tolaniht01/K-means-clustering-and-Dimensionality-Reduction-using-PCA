function K_means(M,c)

%size(M);
%M;
[m n]=size(M);
Y=dlmread('label.txt',',');
size(Y);
idx = kmeans(M,c); % stores the class prediction
size(idx);
A=zeros(1,c);

for i=1:5000
 A(1,idx(i,1))=A(1,idx(i,1))+1;    
end

%A

Y1=zeros(m,1); % stores the actual presentation
for i=1:m
    for j=1:10
        if Y(i,j)==1
            Y1(i,1)=j; % the number it represents 0 reprresnts 1 and 9 by c
        end
    end
    
end
numb_correct=0;
class=zeros(c,10);

for i=1:c
    for j=1:5000
        if idx(j,1)==i
        class(idx(j,1),Y1(j,1))=class(idx(j,1),Y1(j,1))+1;
        end
    end
end
   %disp('Confusion Matrix');
   class;
   %disp('----------------------------------------');
   %A
   disp('Each class Mapping');
   class_map=zeros(c,1);
   
   for i=1:c
       index=0;
       max=0;
       for j=1:10
           if(class(i,j)>max)
               index=j;
              max=class(i,j);
           end
       end
       class_map(i,1)=index;
   end
   
   class_map
   disp('-----------------------------------');
   
   con=zeros(10,10);
   
%    for i=1:5000
%        Y1(i,1)=class_map(idx(i,1));
%        con(Y1(i,1),idx(i,1))=con(Y1(i,1),idx(i,1))+1;
%        if Y1(i,1)==class_map(idx(i,1))
%            numb_correct=numb_correct+1;
%        end
%    end
%    
   
   predict=zeros(5000,2);
   for i=1:5000
       predict(i,1)=class_map(idx(i,1),1);
       predict(i,2)=Y1(i,1);
       con(predict(i,2),predict(i,1))=con(predict(i,2),predict(i,1))+1;
       if(predict(i,1)==predict(i,2))
           numb_correct=numb_correct+1;
       end   
   end
   %predict
   accuracy=numb_correct/5000*100
   disp('confusion Matrix');
   con  
   disp('---------------------------------------');

    







%Y1
