function out=predict_texture_rect_bw(image, color)%RECT (BIANCHI E NERI)

load("classificatori\class_blackwhite.mat");



% im = rgb2gray(imread(image));
im = rgb2gray(image);
 
%converto in grigio se e' RGB

%imshow(im);

% Calcolo i descrittori
f_lbp = compute_lbp(im);
f_ghist = compute_ghist(im);
f_glcm = compute_glcm(im);

ftr = [training.ghist,training.lbp, training.glcm];
%fts = [test.ghist,test.lbp, test.glcm];
fts =[f_ghist,f_lbp, f_glcm];

%%%KNN 
%cart = fitcknn(ftr, training.labels, "NumNeighbors",6,'NSMethod','exhaustive','Distance','cosine');
%cart = fitcknn(ftr, training.labels, "NumNeighbors",8);
%1 FP

%%%TREE
%cart = fitctree(ftr,training.labels);
%%%SVM
%------<cart =  fitcsvm(ftr, training.labels);
cart = fitcecoc(ftr, training.labels);

predicted_train = predict(cart,ftr);
performance_train = confmat(training.labels,predicted_train);
predicted_test = predict(cart,fts);

%performance_test = confmat("", predicted_test)
performance_test = confmat([color], predicted_test);
%pause(5);
out = predicted_test{1,1};
end