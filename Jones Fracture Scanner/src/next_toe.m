function [ bottom, remainingtoes, toe ] = next_toe( toes, prev )
%% Find the next gap between toes, given a boundary that runs along a certain number of toes and the y-value of the last gap

    dim = size(toes);
    thresh = prev * .60;
    for x = 30:dim(1)-10 %% the next gap between toes should happen more than 30 pixels to the right of the previous gap
        prevpoints = toes(x-10:x-1, :);
        nextpoints = toes(x+1:x+10, :);
        %%take the previous and next 10 points and average them around the
        %%point of interest
        prevavg = sum(prevpoints(:,1))/10.0;
        nextavg = sum(nextpoints(:,1))/10.0;
        if nextavg < toes(x, 1) && prevavg < toes(x, 1) && toes(x, 1) > thresh
            %%if the points before and after the point of interest are
            %%north of the point of interest and it is close to the y-value
            %%of the last gap, accept it as the next gap
            bottom = [toes(x,1), toes(x,2)];
            remainingtoes = toes(x+1:end, :); %%cut off the remaining toes to be processed
            toe = toes(1:x, :); %%cut off the toe that was just found
            return;
        end
    end
    toe = [];
    bottom = [];
    remainingtoes = [];
    return;
end

