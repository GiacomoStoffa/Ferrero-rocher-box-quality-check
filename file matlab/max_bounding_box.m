function [xC,yC] = max_bounding_box(binaryImage)
[labeledImage, ~] = bwlabel(binaryImage);
measurements = regionprops(labeledImage, 'Centroid');

xCentroid = measurements.Centroid(1);
yCentroid = measurements.Centroid(2);
[rows, columns] = find(binaryImage);
xCorners = [0 0 0 0]; 
yCorners = [0 0 0 0]; 
maxDistance = [0 0 0 0]; % dal centro in ogni quadrante
for k = 1 : length(columns)
  rowk = rows(k);
  colk = columns(k);
  distanceSquared = (colk - xCentroid)^2 + (rowk - yCentroid)^2;
  if rowk < yCentroid
    % nella meta' in alto
    if colk < xCentroid
      % alto sx
      if distanceSquared > maxDistance(1)
        maxDistance(1) = distanceSquared;
        xCorners(1) = colk;
        yCorners(1) = rowk;
      end
    else
    %alto dx
      if distanceSquared > maxDistance(2)
        maxDistance(2) = distanceSquared;
        xCorners(2) = colk;
        yCorners(2) = rowk;
      end
    end
  else
    % nella meta' in basso
    if colk < xCentroid
      % basso sx
      if distanceSquared > maxDistance(4)
        maxDistance(4) = distanceSquared;
        xCorners(4) = colk;
        yCorners(4) = rowk;
      end
    else
      if distanceSquared > maxDistance(3)
        %basso destra
        maxDistance(3) = distanceSquared;
        xCorners(3) = colk;
        yCorners(3) = rowk;
      end
    end
  end
end


xC = xCorners;
yC = yCorners;
end