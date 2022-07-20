function second_difference = calculate_second_difference(spin, data, size, v, i, plus)
    second_difference = 0;  
    for ver = 1 : size
        if(spin(ver,i) && data(v,ver))
            if(plus)
                second_difference = second_difference + 1;
            else
                second_difference = second_difference - 1;
            end
        end
    end
end