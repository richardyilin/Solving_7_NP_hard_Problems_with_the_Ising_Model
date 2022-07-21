function asymetric_traveling_salesman(file_name)
    fileID = fopen(file_name,'r');
    buffer = fscanf(fileID,'%d');
    fclose(fileID);
    size = buffer(1,1);
    data = zeros(size);
    max_weight = -Inf;
    for i = 1 : size 
        for j = 1 : size
            weight = buffer(((i-1) * size + j + 1),1);
            data(i,j) = weight;
            if (max_weight < weight && i ~= j)
                max_weight = weight;
            end 
        end
    end
    initial_graph(data);
    A = max_weight;
    error_rate = 0.01;
    init_t = max_weight;
    infinite_factor = 100;
    min_t = (error_rate/(size * (log2(size) * 3 / 2)));
    beta = 1.0 / ( max_weight * infinite_factor);
    same_energy_count = 0;
    break_count = 1000;
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
    last_total_energy = Inf;
    while(current_t>min_t)            
        for v = 1 : size
            for j = 1 : size
                if(spin(v,j))% 1 to 0
                    first_sum_j_next(v,1) = first_sum_j(v,1) - 1;
                    second_sum_v_next(j,1) = second_sum_v(j,1) - 1; 
                    third_difference = asymetric_traveling_salesman_calculate_third_difference(spin, data, size, v, j, false) ;                                           
                else % 0 to 1
                    first_sum_j_next(v,1) = first_sum_j(v,1) + 1;
                    second_sum_v_next(j,1) = second_sum_v(j,1) + 1;
                    third_difference = asymetric_traveling_salesman_calculate_third_difference(spin, data, size, v, j, true) ;     
                end
                first_sum_v_next = first_sum_v - mpower((1-first_sum_j(v,1)),2) + mpower((1-first_sum_j_next(v,1)),2);
                second_sum_j_next = second_sum_j - mpower((1-second_sum_v(j,1)),2) + mpower((1-second_sum_v_next(j,1)),2);
                energy_difference = (A * (first_sum_v_next - first_sum_v + second_sum_j_next - second_sum_j)) + third_difference;
                if (energy_difference < 0)
                    spin(v,j) = (~spin(v,j));
                    first_sum_v = first_sum_v_next; 
                    first_sum_j(v,1) = first_sum_j_next(v,1);
                    second_sum_j = second_sum_j_next;
                    second_sum_v(j,1) = second_sum_v_next(j,1);
                    third_sum = third_sum + third_difference;
                    total_energy = first_sum_v + second_sum_j +third_sum;                       
                else
                    prob = exp(-energy_difference/current_t);
                    if (prob>rand)
                        spin(v,j) = (~spin(v,j));
                        first_sum_v = first_sum_v_next; 
                        first_sum_j(v,1) = first_sum_j_next(v,1);
                        second_sum_j = second_sum_j_next;
                        second_sum_v(j,1) = second_sum_v_next(j,1);
                        third_sum = third_sum + third_difference;
                        total_energy = first_sum_v + second_sum_j +third_sum; 
                    end                        
                end      
            end                
        end
        fprintf("first sum  %d second sum %d third sum %d current t %f total energy %d\n",first_sum_v, second_sum_j, third_sum, current_t, total_energy);
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
    %asymetric_traveling_salesman_second_graph(spin);
    ising_configuration_2D(spin);
    hamiltonian_cycle_asymetric_traveling_salesman_graph(spin);
end

function third_difference = asymetric_traveling_salesman_calculate_third_difference(spin, data, size, v, j, plus)
    third_difference = 0;
    if(j > 1 && j < size)
        for ver = 1 : size % cancel the punishment j-1 to j           
            if (spin(ver,j+1)) % spin[v][j]  is xuj
                if(plus)
                    third_difference = third_difference + data(v,ver);
                else
                    third_difference = third_difference - data(v,ver);
                end               
            end
            if (spin(ver,j-1)) %spin[v][j]  is x v j+1
                if(plus)
                    third_difference = third_difference + data(ver,v);
                else
                    third_difference = third_difference - data(ver,v);
                end
            end   
        end
    elseif(j == size)
        for ver = 1 : size % cancel the punishment j-1 to j           
            if (spin(ver,1)) % spin[v][j]  is xuj
                if(plus)
                    third_difference = third_difference + data(v,ver);
                else
                    third_difference = third_difference - data(v,ver);
                end               
            end
            if (spin(ver,size-1)) %spin[v][j]  is x v j+1
                if(plus)
                    third_difference = third_difference + data(ver,v);
                else
                    third_difference = third_difference - data(ver,v);
                end
            end   
        end
    else
        for ver = 1 : size % cancel the punishment j-1 to j           
            if (spin(ver,2)) % spin[v][j]  is xuj
                if(plus)
                    third_difference = third_difference + data(v,ver);
                else
                    third_difference = third_difference - data(v,ver);
                end               
            end
            if (spin(ver,size)) %spin[v][j]  is x v j+1
                if(plus)
                    third_difference = third_difference + data(ver,v);
                else
                    third_difference = third_difference - data(ver,v);
                end
            end   
        end
    end
end