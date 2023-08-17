function [distance_map, dist_counts] = create_distance_map(scale)
%distance map for fast radial average

n = (scale-1)/2;
[X,Y] = meshgrid(-n:n);
distance_map = round(sqrt(X.^2+Y.^2));
distance_map = distance_map(:);
dist_counts = accumarray(distance_map,ones(scale*scale,1));

end %function