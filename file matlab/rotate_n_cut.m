function out_image=rotate_n_cut(image,bwmask)



im = imrotate(image,45); %45 gradi perche' sono gia' girate dritte
BW = imrotate(bwmask,45);
[xc,yc] = max_bounding_box(BW);

FI = im .* BW;

%1      %3

%2      %4
 origImgVertex = [xc(1,1) yc(1,1); xc(1,4) yc(1,4); xc(1,2) yc(1,2);xc(1,3) yc(1,3)];
% hold on;
%  x= 1;
% y= 1;
% plot(x,y, 'bs', xc(1,1), yc(1,1), 'b*');%blu
% plot(x,y, 'bs', xc(1,2), yc(1,2), 'r*');%rosso
% plot(x,y, 'bs',  xc(1,3), yc(1,3), 'g*');%verde
% plot(x,y, 'bs', xc(1,4), yc(1,4), 'y*');%giallo


 height = 100;
 width = 100;
TFORM=cp2tform(origImgVertex,[1 1; height 1; 1 width; height width],'projective'); 
[A,xdata,ydata] =imtransform(FI,TFORM,'XData',[1 width],'YData',[1 height],'XYScale',[1 1]);



% PRINT IMAGES
% random = rand([1,1]);
% randStr = num2str(random);
% path = strcat('ritagli/', randStr);
% imwrite(A, strcat(path,'.png'));



[x,y,m1,n1]  = get_rect(xc,yc);
rect = [x,y,m1,n1];
% 
% hold on;
%                 
%plot(x, y, 'bs', x, y, 'r*');
             
fi_im = imcrop(im,rect);


out_image = A;
end