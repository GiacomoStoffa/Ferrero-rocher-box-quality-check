function out=classify_shape(BW, ratioMax)
[B,L,~] = bwboundaries(BW);
%B traces the exterior boundaries of objects,
%label matrix L where objects and holes are labeled

%get stats
% stats=  regionprops(L, 'Centroid', 'Area', 'Perimeter');
% Centroid = cat(1, stats.Centroid);
% Perimeter = cat(1,stats.Perimeter);
% Area = cat(1,stats.Area);




boundary = B{1};




% x =1;
% y= 1;
% plot(x,y, 'bs', rx(1), ry(1), 'b*');
% plot(x,y, 'bs', rx(2), ry(2), 'r*');
% plot(x,y, 'bs', rx(3), ry(3), 'g*');
% plot(x,y, 'bs',rx(4), ry(4), 'y*');



%%%%%
st = regionprops(BW, 'BoundingBox','Eccentricity');

% st.BoundingBox;
% pointsbb = ([st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)]);
% 
% xCoordsbb = [st.BoundingBox(1), st.BoundingBox(1)+st.BoundingBox(3),st.BoundingBox(1)+st.BoundingBox(3), st.BoundingBox(1), st.BoundingBox(1)];
% yCoordsbb = [st.BoundingBox(2), st.BoundingBox(2), st.BoundingBox(2)+st.BoundingBox(4), st.BoundingBox(2)+st.BoundingBox(4), st.BoundingBox(2)];
% bb = rectangle('Position',[st.BoundingBox(1),st.BoundingBox(2),st.BoundingBox(3),st.BoundingBox(4)],...
%     'EdgeColor','r','LineWidth',2 );


eccentricity = st.Eccentricity;





%get width and height of bounding box


%define some thresholds for each metric

if(eccentricity > 0.57 && ratioMax > 1.3)
    shape = "Rectangle";
else
    shape = "Square";
end

out = shape;