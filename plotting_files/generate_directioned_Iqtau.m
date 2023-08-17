function []=generate_directioned_Iqtau(angle_mask_list,distance_map,dist_counts,nonAvgIqtau,path,filename)

    angle_Iqtau=zeros(size(angle_mask_list,3),size(dist_counts,1),size(nonAvgIqtau,3));
    
    for tau=1:size(nonAvgIqtau,3)
        shifted_nonAvgIqtau=fftshift(nonAvgIqtau(:,:,tau));
        for mask_num=1:size(angle_mask_list,3)
            
            oneD_power_spectrum = ...
            accumarray(distance_map,...
            reshape(squeeze(angle_mask_list(:,:,mask_num)).*shifted_nonAvgIqtau,[],1) )./ ...
            dist_counts;	% radial average
            
            angle_Iqtau(mask_num,:,tau)=oneD_power_spectrum;
        end
    end
    
    output=[path filename(1:end-4) '_angle_Iqtau.mat'];
    save(output,'angle_Iqtau');
end


