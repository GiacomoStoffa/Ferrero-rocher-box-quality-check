function out = classify_bollino(image)

%%IMMAGINE GIA RITAGLIATA
%image = im2double(imread(image));


gray_fi = rgb2hsv(image);
gray_fi = gray_fi(:,:,2);

y = graythresh(gray_fi);
%bw = imbinarize(gray_fi,y);
bw = imbinarize(gray_fi,0.4);% soglia calcolata trial & error

bw = imerode(bw, strel("disk",1,0));



bw = imclose(bw, strel("disk",10,0));

bw = imerode(bw, strel("disk",4,0));


% figure(7), imshow(1-bw);

bw = 1-bw;
[l,num] = bwlabel(bw,4);
c = 0;


bollini = [];
%%2:num se E' SCATOLA PER TOGLIERE LO SFONDO
%%1:num se E' CIOCCOLATINO SINGOLO
for i = 1:num%tolgo il primo che e' lo sfondo

    
    mask = l==i;
    rp = regionprops(mask, "Circularity", "Centroid");
    
    

    if (rp.Circularity >= 0.75 && rp.Circularity <= 1.3)
        %bollo= [rp.Centroid(:,1);rp.Centroid(:,2)];
        %bollini = [bollini bollo];
        s = sum(l(:) == i);
%         figure(54), imshow(mask50.*image),title(rp.Circularity);
%         disp("oggetto n" );

        if (s > 350 && s < 2000)
            c = c+1;
%             disp("BOLLINO");
%              figure(54), imshow(mask.*image),title(rp.Circularity);
%              pause(10);

        end

    end

    
    
end


%figure(14);imagesc(l), axis image, colorbar,title(num2str(c));
%figure(4),imshow(bw);
%hold on;
%x = imcontour(bw,2);
%out = bollini;
out = c;