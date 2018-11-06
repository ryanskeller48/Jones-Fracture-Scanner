function [coord] = find_top_pixel(BW)
    dim = size(BW);
    for y = 1:dim(1)
        for x = 1:dim(2)
            if BW(y, x) == 1
                col = BW(y:y+3, x);
                if sum(col) == 3
                    coord = [y x];
                    return;
                end
            end
        end
    end
    coord = [0 0];
    return;

