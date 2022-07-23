function graph_partitioning(file_name)
    fileID = fopen(file_name,'r');
    buffer = fgetl(fileID);
    buffer2 = str2double(split(buffer));
    len = buffer2(1,1);
    edge = buffer2(2,1);
    data = false(len);
    max_degree = 0;
    for i = 1 : len
        start = i;
        buffer = fgetl(fileID);
        buffer2 = str2double(split(buffer));
        for j = 1 : length(buffer2)
            over = buffer2(j,1);
            data(start,over) = 1;
        end
        degree = length(buffer2);
        if (degree > max_degree)        
            max_degree = degree;
        end 
    end
    fclose(fileID);
    initial_graph(data);
    denominator = 8;
    if (len > 2 * max_degree)
        A = max_degree * 2 / denominator;
    else
        A = len / denominator;
    end
    error_rate = 0.01;
    infinite_factor = 100;
    min_t = (error_rate/(len * (log2(len)) * 3 / 2));
    %init_t = max_degree/8;
    %beta = 1.0 / (max_degree * infinite_factor);
    if (A > max_degree)
        init_t = A ;
        beta = 1.0 / (A * infinite_factor);
    else
        init_t = max_degree ;
        beta = 1.0 / (max_degree * infinite_factor);
    end
    same_energy_count = 0;
    break_count = 100;
    current_t=init_t;
    spin = ones(len,1);
    lfa = zeros(len);
    for i = 1 : len
        for j = 1 : len
            if(data(i,j))
                lfa(i,1) = lfa(i,1) + 1;
            end
        end
    end   
    last_first_sum = 0;
    last_second_sum = 0;
    first_sum = len;
    second_sum = edge;
    while(current_t>min_t)      
        for v = 1 : len
            if (spin(v,1) == 1) % 1 to -1
                first_sum_next = first_sum - 2;
                second_difference = -2 * lfa(v,1);
            else% // -1 to 1
                first_sum_next = first_sum + 2;
                second_difference = 2 * lfa(v,1);
            end 
            energy_difference = A * (mpower(first_sum_next, 2) - mpower(first_sum, 2)) - second_difference; % maximize second term
            if (energy_difference < 0)
                spin(v,1) = (-spin(v,1));
                for i = 1 : len
                    if (data(v,i))
                        lfa(i,1) = lfa(i,1) + 2 * spin(v,1);
                    end
                end
                first_sum = first_sum_next;
                second_sum = second_sum + second_difference;
            else
                prob = exp(-energy_difference/current_t);
                if (prob>rand)
                    spin(v,1) = (-spin(v,1));
                    for i = 1 : len
                        if (data(v,i))
                            lfa(i,1) = lfa(i,1) + 2 * spin(v,1);
                        end
                    end
                    first_sum = first_sum_next;
                    second_sum = second_sum + second_difference;
                end  
            end
        end
        fprintf('first sum %d second sum %d current t %f\n', first_sum, second_sum, current_t);
        current_t = current_t / (1 + beta * current_t);      
        if (abs(last_first_sum) == abs(first_sum) && last_second_sum == second_sum)
            if (same_energy_count == break_count)
                break;
            end            
            same_energy_count = same_energy_count + 1;
        else
            same_energy_count = 0;
            last_first_sum = first_sum;
            last_second_sum = second_sum;
        end  
    end
    ising_configuration_1D(spin);
    graph_partitioning_max_cut_final_graph(data,spin);
end