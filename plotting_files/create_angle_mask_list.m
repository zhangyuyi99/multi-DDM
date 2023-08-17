function angle_mask_list=create_angle_mask_list(scale,angle_num)
    mask_list = zeros(scale,scale,angle_num);
    half_angle = 0.5*pi/angle_num;
    
    for n=1:angle_num
        mask=zeros(scale);
        radius=scale/2;
        if (half_angle+(n-1)*2*half_angle)>pi/2 && (-half_angle+(n-1)*2*half_angle)<pi/2
            for i=1:size(mask,1)
                for j=1:size(mask,2)
                    current_tan=((i-radius)/(j-radius));
                    if j~=radius && tan(half_angle+(n-1)*2*half_angle)>current_tan || tan(-half_angle+(n-1)*2*half_angle)<current_tan
                        mask(i,j)=1;
                    end
                end
            end
            mask(:,radius)=1;
        else
             for i=1:size(mask,1)
                for j=1:size(mask,2)
                    current_tan=((i-radius)/(j-radius));
                    if j~=radius && tan(half_angle+(n-1)*2*half_angle)>current_tan && tan(-half_angle+(n-1)*2*half_angle)<current_tan
                        mask(i,j)=1;
                    end
                end
            end
        end
%         figure(n);
%         imshow(mask);
%         drawnow;
%         saveas(gcf,[num2str(n) '.jpg'])
        mask_list(:,:,n)=mask;

    end
    
    angle_mask_list=mask_list;
end
