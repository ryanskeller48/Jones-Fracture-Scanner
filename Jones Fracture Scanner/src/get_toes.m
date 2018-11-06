function [ toes ] = get_toes( boundary, colleft, colright, height )
%% Finds toes boundary, which we define from the top of the right toe to the left edge of the bottom boundary with y value greater than half of the height

    dim = size(boundary);
    toes = ones(0,2);
    thresh = height/2.2;
    for x = 1:dim(1)
        col = boundary(x, 2);
        row = boundary(x, 1);
        if col < colright && col > colleft && row < thresh
            newpoint = [row col];
            toes = [toes;newpoint];
        end
    end


end

