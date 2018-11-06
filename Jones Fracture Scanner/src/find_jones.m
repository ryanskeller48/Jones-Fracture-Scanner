function [ jones ] = find_jones( basetoe, basefoot )
    distance = sqrt((basetoe(1) - basefoot(1))^2 + (basetoe(2) - basefoot(2))^2);
    angle = asind((basetoe(2)-basefoot(2))/distance);
    jonesdistance = 4.0 * distance/9.0; %% assume Jones fracture is 4/9 of the way up the metatarsal
    xoffset = jonesdistance * sin(deg2rad(angle));
    yoffset = jonesdistance * cos(deg2rad(angle));
    jones = [basefoot(1) - round(yoffset) basefoot(2) + round(xoffset)]; %% some trig gives us the point 4/9 of the way up the metatarsal
    return;

end

