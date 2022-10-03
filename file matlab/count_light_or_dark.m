function type = count_light_or_dark(image)


[m,n,~] =size(image);

dark = 0;
light = 0;
for r=1:m
    for c=1:n
        value = image(r,c);
        if value > 0.5 %chiara
            light = light + 1;
        else %scura
            dark = dark + 1;
        end
        
    end
end

%d = dark;
%l = light;

% dark
% light
if (dark > light)
    type = 'dark';
else
    type = 'light';
end
end

