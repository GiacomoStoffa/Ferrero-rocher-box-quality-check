
%%% COUNT TEST SCATOLE QUADRATE CHIARE

%image = "quadgiuste\IMG_8628.jpg";


function out = count_square_light(image, square)
%%RITAGLIA IMMAGINE
%image = ritaglioscatolav2(im2double(imread(image)));

%%IMMAGINE GIA RITAGLIATA
%image = im2double(imread(image));


gray_fi = rgb2hsv(image);
gray_fi = gray_fi(:,:,2);

y = graythresh(gray_fi);
bw = imbinarize(gray_fi,y); % soglia con OTSU



bw = imclose(bw, strel("disk",3,0));
bw = imopen(bw, strel("disk",1,0));


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

    if (rp.Circularity >= 0.8 && rp.Circularity <= 1.2) % threshold bollino
        bollo= [rp.Centroid(:,1);rp.Centroid(:,2)];
        bollini = [bollini bollo]; %%COORDS OF STICKERS
        
        %figure(54), imshow(mask50.*image),title(rp.Circularity);
        % pause(3);
        s = sum(l(:) == i);
        %     if (s == 120)
        %         pause(10);
        %     end
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
        
        
    end
end


%figure(14);
% imagesc(l), axis image, colorbar,title(num2str(c));
% figure(46),imshow(bw);
% 
% pause(5);
% %hold on;
% x = imcontour(bw,2);
%out = bollini;
out = c;
end