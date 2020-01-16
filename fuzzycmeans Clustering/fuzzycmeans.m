% This program illustrates the Fuzzy c-means segmentation of an image. 
% This program converts an input image into two segments using Fuzzy k-means
% algorithm. The output is stored as "fuzzysegmented.jpg" in the current directory.
% This program can be generalised to get "n" segments from  an image
% by means of slightly modifying the given code.
clear all;clc;
m=0.000001;
IM=imread('Image1.jpg');
%imshow(IM1)
figure('color','w')  
subplot(1,3,1), imshow(IM);
set(get(gca,'Title'),'String','Original');
IM = rgb2gray(IM);
IM=double(IM);
IM=(IM-min(IM(:)))/(max(IM(:))-min(IM(:))); %Normalizing the image

%imshow(uint8(IM));
[maxX,maxY]=size(IM);
IMM=cat(3,IM,IM);

% Defining initial cluster centers
cc1=8;
cc2=250;

%% 
ttFcm=0;   
while(ttFcm<15)   %Defined an initial number of iterations
    ttFcm=ttFcm+1
    
    c1=repmat(cc1,maxX,maxY); %create a maxX,maxY size matrix whose elements contain value cc1
    %disp(c1);
    c2=repmat(cc2,maxX,maxY);  %create a maxX,maxY size matrix whose elements contain value cc2
    if ttFcm==1 
        test1=c1; 
        test2=c2;
    end
    c=cat(3,c1,c2);
    
    ree=repmat(m,maxX,maxY);
    ree1=cat(3,ree,ree);
    
    distance=IMM-c; %taking difference between original image and cluster centroids
    distance=distance.*distance+ree1;
    
    check=1./distance;
    
    check2=check(:,:,1)+check(:,:,2);
    distance1=distance(:,:,1).*check2;
    u1=1./distance1;
    distance2=distance(:,:,2).*check2;
    u2=1./distance2;
      
    ccc1=sum(sum(u1.*u1.*IM))/sum(sum(u1.*u1));
    ccc2=sum(sum(u2.*u2.*IM))/sum(sum(u2.*u2));
   
    tmpMatrix=[abs(cc1-ccc1)/cc1,abs(cc2-ccc2)/cc2];
    pp=cat(3,u1,u2);
    %% 
    
    for i=1:maxX
        for j=1:maxY
            if max(pp(i,j,:))==u1(i,j)
                IX2(i,j)=1;
           
            else
                IX2(i,j)=2;
            end
        end
    end
    %%%%%%%%%%%%%%%
    %% 
   if max(tmpMatrix)<0.0001
         break;
  else
         cc1=ccc1;
         cc2=ccc2;
        
  end

 for i=1:maxX
       for j=1:maxY
            if IX2(i,j)==2
            IMMM(i,j)=254;
                 else
            IMMM(i,j)=8;
       end
    end
end
%%%%%%%%%%%%%%%%%%

IMMM=uint8(IMMM);
y=colormap(colorcube(720));
imwrite(IMMM,y,'rgb.jpg','jpg')
subplot(1,3,2), imshow('rgb.jpg');
set(get(gca,'Title'),'String','Cluster 1');
end
%% 

for i=1:maxX
    for j=1:maxY
         if IX2(i,j)==2
             IMMM(i,j)=200;
             else
             IMMM(i,j)=1;
    end
  end
end 

%%%%%%%%%%%%%%%%%%
IMMM=uint8(IMMM);
y=colormap(hot(480));
imwrite(IMMM,y,'rgb.jpg','jpg')
subplot(1,3,3), imshow('rgb.jpg');
set(get(gca,'Title'),'String','Cluster 2');

%% 
%imshow(IMMM);
disp('The final cluster centers are');
ccc1
ccc2