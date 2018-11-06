function [ bases ] = find_base_of_metatarsals( colleft, colright )
    diff = colright - colleft;
    spacing = round(diff/4.0);
    bases = [colleft + spacing colleft + spacing * 2 colleft + spacing * 3];
    return;
end

