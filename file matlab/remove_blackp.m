function out_image = remove_blackp(image)


[m,n,~] =size(image);

avColor = mean(image(:));

for r=1:m
    for c=1:n
        value = image(r,c);
        if value == 0
            image(r,c)= avColor;
        end
       
    end
end


out_image=image;
