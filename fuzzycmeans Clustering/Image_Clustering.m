IM = imread('Image1.jpg');
figure('color','w')  
subplot(1,3,1), imshow(IM);
set(get(gca,'Title'),'String','Original');

cform = makecform('srgb2lab');
lab_IM = applycform(IM,cform);
img = double(lab_IM(:,:,2:3));
nrows = size(img,1);
ncols = size(img,2);
img = reshape(img,nrows*ncols,2);

nColors = 2;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(img,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);
clustered_images = cell(1,2);
img_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = IM;
    color(img_label ~= k) = 0;
    clustered_images{k} = color;
end

subplot(1,3,2), imshow(clustered_images{1});
set(get(gca,'Title'),'String','Cluster 1');

subplot(1,3,3), imshow(clustered_images{2});
set(get(gca,'Title'),'String','Cluster 2');


