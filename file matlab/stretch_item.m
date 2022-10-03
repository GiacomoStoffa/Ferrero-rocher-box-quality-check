function out_image=stretch_item(image,xc,yc)


origImgVertex = [xc(1,1) yc(1,1); xc(1,4) yc(1,4); xc(1,2) yc(1,2);xc(1,3) yc(1,3)];

% height = 55;
% width = 55;
 height = 100;
 width = 100;

 %%%OLD
%TFORM=cp2tform(origImgVertex,[1 1; height 1; 1 width; height width],'projective'); 
%[A,xdata,ydata] =imtransform(image,TFORM,'XData',[1 width],'YData',[1 height],'XYScale',[1 1]);

%%%NEW
TFORM=fitgeotrans(origImgVertex,[1 1; height 1; 1 width; height width],'projective');
RA = imref2d([height width],[1 width], [1 height]);
[A,~] = imwarp(image, TFORM, 'OutputView', RA);


%%% SAVE IMAGE
% random = rand([1,1]);
% randStr = num2str(random);
% path = strcat('ritagliRettangoli/', randStr);
% imwrite(A, strcat(path,'.png'));

out_image = A;
end