%% Read image and convert to black and white

I = imread('top.jpg');
BW = im2bw(I);
figure;
imshow(BW);
title('black and white');

%% Find top of foot and start boundary from there


top5 = find_top_pixel(BW); %% find northernmost pixel that is white to start boundary (only 1 object)
boundary = bwtraceboundary(BW,[top5(1), top5(2)],'SW');

figure;
imshow(I);
hold on;
plot(boundary(:, 2), boundary(:, 1),'g','LineWidth',3);
title('foot boundary');
hold off;

%% Find where foot meets the bottom of the image (the end of the metatarsals, the bone of interest)


dim = size(BW);

[start, ended, colleft, colright] = find_bottom(boundary, dim(1)); %% find bottom of boundary where it is flat

figure;
imshow(I);
hold on;
plot(boundary(start:ended, 2), boundary(start:ended, 1),'g','LineWidth',3);
title('bottom boundary');
hold off;

%% Find the boundary points that lay along the toes


toes = get_toes(boundary, colleft, top5(2)-20, dim(1));

figure;
imshow(I);
hold on;
plot(toes(:,2), toes(:,1),'g','LineWidth',3);
title('the toes');
hold off;

%% Segment out each of the middle three toes


[bottom, index] = identify_toes(toes); %% gives the lowest point in the toe boundary, 
                                        %%which corresponds to the bottom of the gap between the pinky and ring toes
[bottom2, remainingtoes, toe2] = next_toe(toes(index:end, :), bottom(1)); %% get each next toe sequentially based on where the last one ended
[bottom3, remainingtoes2, toe3] = next_toe(remainingtoes, bottom2(1));
[bottom4, remainingtoes3, toe4] = next_toe(remainingtoes2, bottom3(1));

figure;
imshow(I);
hold on;
plot(toe2(:,2), toe2(:,1),'g','LineWidth',3);
title('toe 2');
hold off;

figure;
imshow(I);
hold on;
plot(toe3(:,2), toe3(:,1),'g','LineWidth',3);
title('toe 3');
hold off;

figure;
imshow(I);
hold on;
plot(toe4(:,2), toe4(:,1),'g','LineWidth',3);
title('toe 4');
hold off;

%% Using the segmented toes, find the top of each


top1 = find_top(toes(1:index, :)); %searches for the lowest y value (top of image) in each segmented toe
top2 = find_top(toe2);
top3 = find_top(toe3);
top4 = find_top(toe4);

%% Using the coordinates of the tops of toes and the gaps in between them, we can identify where the toe meets the foot 
%%  (where the phalanges meet the metatarsals)


basetoe1 = [bottom(1) top1(2)]; %% the base of the big toe is directly below the top at the height of the gap between the big and adjacent toe
basetoe2 = [round((bottom(1) + bottom2(1))/2)  round((bottom(2) + bottom2(2))/2)]; %% the middle 3 toes get their bases from the midpoint of the gaps surrounding the toe
basetoe3 = [round((bottom2(1) + bottom3(1))/2)  round((bottom2(2) + bottom3(2))/2)];
basetoe4 = [round((bottom3(1) + bottom4(1))/2)  round((bottom3(2) + bottom4(2))/2)];
basetoe5 = [bottom4(1) top5(2)-20]; %% pinky toe is treated like the big toe

%% Find the location of the bottom of the metatarsals using the bottom boundary we found earlier


basefoot5 = [dim(1)-20, colright]; %% base of big and pinky metatarsals are based on the bottom of the foot boundary from earlier
basefoot1 = [dim(1)-20, colleft];

bases = find_base_of_metatarsals(colleft, colright); %% evenly spreads the three remaining metatarsals between the big and pinky metatarsals

basefoot2 = [dim(1)-20, bases(1)];
basefoot3 = [dim(1)-20, bases(2)];
basefoot4 = [dim(1)-20, bases(3)];

%% Plot the phalanges in red and the metatarsals in white


figure;
imshow(I);
hold on;

plot([top5(2) basetoe5(2)], [top5(1) basetoe5(1)],'r','LineWidth',3);
plot([top4(2) basetoe4(2)], [top4(1) basetoe4(1)],'r','LineWidth',3);
plot([top3(2) basetoe3(2)], [top3(1) basetoe3(1)],'r','LineWidth',3);
plot([top2(2) basetoe2(2)], [top2(1) basetoe2(1)],'r','LineWidth',3);
plot([top1(2) basetoe1(2)], [top1(1) basetoe1(1)],'r','LineWidth',3);

plot([basetoe1(2) basefoot1(2)], [basetoe1(1) basefoot1(1)],'w','LineWidth',3);
plot([basetoe2(2) basefoot2(2)], [basetoe2(1) basefoot2(1)],'w','LineWidth',3);
plot([basetoe3(2) basefoot3(2)], [basetoe3(1) basefoot3(1)],'w','LineWidth',3);
plot([basetoe4(2) basefoot4(2)], [basetoe4(1) basefoot4(1)],'w','LineWidth',3);
plot([basetoe5(2) basefoot5(2)], [basetoe5(1) basefoot5(1)],'w','LineWidth',3);

%% Using information about the outside metatarsal, find the Jones fracture and draw a yellow circle around it


jones = find_jones(basetoe1, basefoot1); %% uses pinky metatarsal data to find location of Jones fracture

th = 0:pi/50:2*pi;
xs = 20 * cos(th) + jones(2);
ys = 20 * sin(th) + jones(1);
plot(xs, ys, 'y','LineWidth',2);
title('bone structure(red/white) and Jones fracture location(yellow)');
hold off;





