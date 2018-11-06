function [ fifthbottom, index ] = identify_toes( toes )
%% Finds the bottommost point in the toes boundary, which we assume is the gap to the right of the pinky toe

    dim = size(toes);
    maxrow = 0;
    col = 0;
    for x = 1:dim(1)
        if toes(x, 1) > maxrow
            maxrow = toes(x, 1);
            col = toes(x, 2);
            index = x;
            z = x;
        end
    end
    fifthbottom = [maxrow col];
    firstfourtoes = toes(z:end);
    return;

end

