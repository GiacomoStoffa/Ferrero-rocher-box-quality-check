
%%% COUNT TEST SCATOLE QUADRATE SCURE

%image = "quadgiuste\IMG_8625.jpg";


function out = count_square_dark(image, square)
%%RITAGLIA IMMAGINE
%image = ritaglioscatolav2(im2double(imread(image)));

%%IMMAGINE GIA RITAGLIATA
%image = im2double(imread(image));


gray_fi = rgb2hsv(image);
gray_fi = gray_fi(:,:,2);
% figure(2), imshow(gray_fi);


%soglia trial & error, bollini molto neri e in generale immagine scura
%quindi si prende una soglia molto basso in modo da separarli
if (square)
    bw = imbinarize(gray_fi,0.05);%0.05 -> sfondo 
else
    bw = imbinarize(gray_fi,0.08);%0.08 -> ritagli 
end

% figure(1919), imshow(imbinarize(gray_fi,y));
% figure(5),imshow(bw);


bw = imerode(bw, strel("disk",1,0));

% figure(6),imshow(bw);


bw = imclose(bw, strel("disk",3,0));
bw = imopen(bw, strel("disk",1,0));

%bw = imdilate(bw, strel("disk",1,0));

% figure(3), subplot(121), plot(imhist(gray_fi)), subplot(122), imshow(bw);
% 
% figure(7), imshow(1-bw);
bw = 1-bw;
[l,num] = bwlabel(bw,4);
c = 0;



bollini = [];
%%2:num se E' SCATOLA PER TOGLIERE LO SFONDO
%%1:num se E' CIOCCOLATINO SINGOLO
for i = 1:num%tolgo il primo che e' lo sfondo
    
    %e50cent = 5; % dall'immagine delle etichette
    
    mask50 = l==i;
    %rp = regionprops(l(:)==i, "Circularity");
    rp = regionprops(mask50, "Circularity", "Centroid");
    
    if (rp.Circularity >= 0.78 && rp.Circularity <= 1.2)
        bollo= [rp.Centroid(:,1);rp.Centroid(:,2)];
        bollini = [bollini bollo];
        
        %figure(54), imshow(mask50.*image),title(rp.Circularity);

        s = sum(l(:) == i);
%         disp("oggetto n" );
%         s
        if (square)
            if (s > 55 && s < 350)
                c = c + 1;
            end
            
        else
            if (s > 250 && s < 800)
                c = c + 1;
            end
            
        end
        
        %     else
        %     figure(54), imshow(mask50.*image),title(rp.Circularity);
        %    pause(6);
    end
end


%figure(14);
% imagesc(l), axis image, colorbar,title(num2str(c));
% figure(4),imshow(bw);

%hold on;
% x = imcontour(bw,2);

out = c;
end