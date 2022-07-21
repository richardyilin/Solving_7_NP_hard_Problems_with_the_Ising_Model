function max_cut(file_name)
    fileID = fopen(file_name,'r');
    buffer = fscanf(fileID,'%d');
    fclose(fileID);
    size = buffer(1,1);
    edge = buffer(2,1);
    degree = zeros(size,1);
    data = zeros(size);
    for i = 1 : edge
        start = buffer(3 * i,1);
        over = buffer(3 * i + 1,1);
        weight = buffer(3 * i + 2,1);
        data(start,over) = weight;
        data(over,start) = weight;
        degree(start,1) = degree(start,1) + 1;
        degree(over,1) = degree(over,1) + 1;
    end
    initial_graph(data);
    max_degree = max(degree);
    error_rate = 0.01;
    last_total_energy = 0;
    infinite_factor = 100;
    init_t = max_degree;
    min_t = (error_rate/(size * (log2(size) / log(2)) * 3 / 2));
    beta = 1.0 / (max_degree * infinite_factor);
    same_energy_count = 0;
    break_count = 100;
    current_t=init_t;
    spin = ones(size,1);
    lfa = zeros(size,1);
    for i = 1 : size
        for j = 1 : size
            lfa(i,1) = lfa(i,1) + data(i,j);
        end        
    end    
    total_weight = max_cut_weight_sum(data, size);   
    total_energy = total_weight;
    while(current_t>min_t)
        for v = 1 : size
            if (spin(v,1) == 1) % 1 to -1
                energy_difference = -2 * lfa(v,1);
            else% // -1 to 1
                energy_difference = 2 * lfa(v,1);
            end 
            if (energy_difference < 0)
                spin(v,1) = (-spin(v,1));
                for i = 1 : size
                    lfa(i,1) = lfa(i,1) + 2 * spin(v,1) * data(v,i);
                end    
                total_energy = total_energy + energy_difference;
            else 
                prob = exp(-energy_difference/current_t);
                if (prob>rand)
                    spin(v,1) = (-spin(v,1));
                    for i = 1 : size
                        lfa(i,1) = lfa(i,1) + 2 * spin(v,1) * data(v,i);
                    end    
                    total_energy = total_energy + energy_difference;
                end                        
            end
        end  
        fprintf('current t %f cut %d\n',current_t, (total_weight - total_energy)/2);
        current_t = current_t / (1 + beta * current_t);
        if (last_total_energy == total_energy)
            if (same_energy_count == break_count)
                break;
            end            
            same_energy_count = same_energy_count + 1;
        else
            same_energy_count = 0;
            last_total_energy = total_energy;
        end 
    end 
    graph_partitioning_max_cut_final_graph(data,size,spin);
end
function total_weight = max_cut_weight_sum(data, size)
    total_weight = 0;
    for i = 1 : size
        for j = 1 : size - 1
            total_weight = total_weight + data(i,j);
        end        
    end
end