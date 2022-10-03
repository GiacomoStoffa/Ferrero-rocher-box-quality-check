function out=predict_texture_quad(image, color)%QUAD

load("classificatori\class_yellow.mat");


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

%cart = fitcknn(ftr, training.labels, "NumNeighbors",6); %% backup



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