function [ start, ended, col1, col2  ] = find_bottom( boundary, depth )
    dim = size(boundary);
    for x = 1:dim(1)
        if boundary(x, 1) == depth
            start = x; %% start of the bottom boundary is when it's y-value is == depth
            col2 = boundary(x, 2); %% get x-coordinate of start of boundary
            for y = start+1:dim(1)
                if boundary(y, 1) ~= depth
                    bound = boundary(y:y+5, 1);
                    if sum(bound) < (depth*5) - 20 %% if a point following a bottom boundary point has a y value != depth, 
                                                    %%check the next 5 points. If they are significantly different from the depth, on average,
                                                    %%this is where the bottom boundary ends
                        ended = y;
                        col1 = boundary(y, 2);
                        return
                    end
                end    
                
            end
        end
    end
    start = 0;
    ended = 0;
    return;
end

