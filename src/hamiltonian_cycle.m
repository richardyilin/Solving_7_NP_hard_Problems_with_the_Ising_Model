function hamiltonian_cycle(file_name)
    fileID = fopen(file_name,'r');
    buffer = fscanf(fileID,'%d');
    fclose(fileID);
    size = buffer(1,1);
    data = false(size);
    degree = zeros(size,1);
    count = 2;
    while(count<length(buffer))
        start = buffer(count,1);
        over = buffer(count + 1,1);
        data(start,over) = true;
        data(over,start) = true;
        count = count + 2;
        degree(start,1) = degree(start,1) + 1;
        degree(over,1) = degree(over,1) + 1;
    end
    initial_graph(data);
    max_degree = max(degree);
    global_minimum = false;
    error_rate = 0.01;
    infinite_factor = 100;
    init_t = max_degree;
    min_t = (error_rate/(size * (log2(size) * 3 / 2)));
    beta = 1.0 / (max_degree * infinite_factor);
    %fprintf('init %f max_degree %d beta %f mint %f\n',init_t, max_degree,beta,min_t);
    last_total_energy = Inf;
    same_energy_count = 0;
    break_count = 100;
    current_t=init_t;
    spin = false(size);
    first_sum_v = size; 
    first_sum_j = zeros(size,1);
    second_sum_j = size;
    second_sum_v = zeros(size,1);
    third_sum = 0;
    first_sum_j_next = zeros(size,1);
    second_sum_v_next = zeros(size,1);
    total_energy = 0;
    while(current_t > min_t)
        for v = 1 : size
            for j = 1 : size
                if(spin(v,j))% // 1 to 0
                    first_sum_j_next(v,1) = first_sum_j(v,1) - 1;
                    second_sum_v_next(j,1) = second_sum_v(j,1) - 1; 
                    third_difference = calculate_third_difference(spin, data, size, v, j, false) ; 
                else%// 0 to 1
                    first_sum_j_next(v,1) = first_sum_j(v,1) + 1;
                    second_sum_v_next(j,1) = second_sum_v(j,1) + 1;
                    third_difference = calculate_third_difference(spin, data, size, v, j, true) ;     
                end
                first_sum_v_next = first_sum_v - mpower((1-first_sum_j(v,1)),2) + mpower((1-first_sum_j_next(v,1)),2);
                second_sum_j_next = second_sum_j - mpower((1-second_sum_v(j,1)),2) + mpower((1-second_sum_v_next(j,1)),2);
                energy_difference = first_sum_v_next - first_sum_v + second_sum_j_next - second_sum_j + third_difference;
                if (energy_difference < 0)                
                    spin(v,j) = (~spin(v,j));
                    first_sum_v = first_sum_v_next; 
                    first_sum_j(v,1) = first_sum_j_next(v,1);
                    second_sum_j = second_sum_j_next;
                    second_sum_v(j,1) = second_sum_v_next(j,1);
                    third_sum = third_sum + third_difference;
                    total_energy = first_sum_v + second_sum_j +third_sum;
                    %fprintf("first sum %d second sum %d third sum %d third difference %d current t %f total energy %d last total energy %d global %d same_energy_count %d min %d\n",first_sum_v,second_sum_j,third_sum,third_difference,current_t,total_energy,last_total_energy,global_minimum,same_energy_count,min_t);
                    if (total_energy == 0)
                        global_minimum = true;
                        break;
                    end           
                elseif(~global_minimum)
                    prob = exp(-energy_difference/current_t);
                    if (prob>rand)
                        spin(v,j) = (~spin(v,j));
                        first_sum_v = first_sum_v_next; 
                        first_sum_j(v,1) = first_sum_j_next(v,1);
                        second_sum_j = second_sum_j_next;
                        second_sum_v(j,1) = second_sum_v_next(j,1);
                        third_sum = third_sum + third_difference;
                        total_energy = first_sum_v + second_sum_j +third_sum;
                        %fprintf("first sum %d second sum %d third sum %d third difference %d current t %f total energy %d last total energy %d global %d same_energy_count %d min %d\n",first_sum_v,second_sum_j,third_sum,third_difference,current_t,total_energy,last_total_energy,global_minimum,same_energy_count,min_t);
                    end                        
                end       
            end                 
        end    
        fprintf("first sum %d second sum %d third sum %d  current t %f total energy %d\n",first_sum_v,second_sum_j,third_sum,current_t,total_energy);
        current_t = current_t / (1 + beta * current_t);
        if (global_minimum)
            break;
        end      
        if (last_total_energy == total_energy)
            if (same_energy_count == break_count)
                break;
            end            
            same_energy_count = same_energy_count + 1;
        else
            last_total_energy = total_energy;
            same_energy_count = 0;
        end        
    end
    hamiltonian_cycle_asymetric_traveling_salesman_graph(spin);
end