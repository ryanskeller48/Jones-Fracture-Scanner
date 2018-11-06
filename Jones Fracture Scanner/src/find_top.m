function [ top ] = find_top( toe )
%% Find min y value (most north point) in each toe and take that as the top of the toe

    dim = size(toe);
    min = 10000;
    top = [];
    for x = 1:dim(1)    
        if toe(x, 1) < min
            min = toe(x,1);
            top = toe(x, :);
        end
    end
    return;
end

