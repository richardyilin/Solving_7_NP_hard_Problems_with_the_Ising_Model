function graph_coloring(file_name)
    fileID = fopen(file_name,'r');
    buffer = fscanf(fileID,'%d');
    fclose(fileID);
    len = buffer(1,1);
    edge = buffer(2,1);
    data = false(len);
    degree = zeros(len,1);
    for i = 1 : edge
        start = buffer(2*i+1,1);
        over = buffer(2*i+2,1);
        data(start,over) = true;
        data(over, start) = true;
        degree(start,1) = degree(start,1) + 1;
        degree(over,1) = degree(over,1) + 1;
    end
    initial_graph(data);
    left = 1;
    right = len;
    ans_color = right;
    ans_spin = false(len, len);
    while (left <= right)
        color = round((left + right)/ 2);
        max_degree = max(degree);
        global_minimum = false;
        last_total_energy = Inf;
        error_rate = 0.01;
        infinite_factor = 100;
        init_t = max_degree;
        min_t = (error_rate/(len * (log2(len)) * 3 / 2));
        beta = 1.0 / (max_degree * infinite_factor);
        same_energy_count = 0;
        break_count = 100;
        current_t=init_t;
        spin = false(len,color);
        first_sum_v = len; 
        first_sum_i = zeros(len,1);
        second_sum = 0;
        first_sum_i_next = zeros(len,1);
        total_energy = 0;
        while(current_t>min_t)       
                for i = 1 : color
                    for v = 1 : len
                        if(spin(v,i))% // 1 to 0
                            first_sum_i_next(v,1) = first_sum_i(v,1) - 1;
                            second_difference = calculate_second_difference(spin, data, len, v, i, false) ;  
                        else % 0 to 1
                            first_sum_i_next(v,1) = first_sum_i(v,1) + 1;
                            second_difference = calculate_second_difference(spin, data, len, v, i, true) ;     
                        end
                        first_sum_v_next = first_sum_v - mpower((1-first_sum_i(v,1)),2) + mpower((1-first_sum_i_next(v,1)),2);
                        energy_difference = first_sum_v_next - first_sum_v + second_difference;
                        if (energy_difference < 0)
                            spin(v,i) = (~spin(v,i));
                            first_sum_v = first_sum_v_next; 
                            first_sum_i(v,1) = first_sum_i_next(v,1);
                            second_sum = second_sum + second_difference;
                            total_energy = first_sum_v + second_sum;
                            if (total_energy == 0)
                                global_minimum = true;
                            end              
                        elseif(~global_minimum) 
                            prob = exp(-energy_difference/current_t);
                            if (prob>rand)
                                spin(v,i) = (~spin(v,i));
                                first_sum_v = first_sum_v_next; 
                                first_sum_i(v,1) = first_sum_i_next(v,1);
                                second_sum = second_sum + second_difference;
                                total_energy = first_sum_v + second_sum;
                            end                        
                        end      
                    end                
                end        
            fprintf("first sum  %d second sum %d current t %f total energy %d color %d\n",first_sum_v, second_sum, current_t, total_energy, color);
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
                same_energy_count = 0;
                last_total_energy = total_energy;
            end 
        end
        fprintf("color %d global_minimum %s\n", color, mat2str(global_minimum));
        if global_minimum
            ans_color = min([ans_color, color]);
            ans_spin = spin;
            right = color - 1;
        else
            left = color + 1;
        end
    end
    fprintf("final color %d\n", ans_color);
    ising_configuration_2D(ans_spin);
    graph_coloring_final_graph(ans_spin, data, ans_color);
end
function graph_coloring_final_graph(spin, data, color)
    spin_size = size(spin,1);
    f = figure;
    R = 1;
    alf=linspace(pi/2,5/2*pi,spin_size+1);
    x = R*cos(alf);
    y = R*sin(alf);
    for u = 1 : spin_size 
        for i = 1 : color
            if(spin(u,i))
                switch i
                    case 1
                        plot(x(u),y(u),'ro');
                    case 2
                        plot(x(u),y(u),'go');
                    case 3
                        plot(x(u),y(u),'bo');
                    case 4
                        plot(x(u),y(u),'co');
                    case 5
                        plot(x(u),y(u),'mo');
                    case 6
                        plot(x(u),y(u),'yo');
                    case 7
                        plot(x(u),y(u),'ko');
                    case 8
                        plot(x(u),y(u),'rs');
                    case 9
                        plot(x(u),y(u),'gs');
                    case 10
                        plot(x(u),y(u),'bs');
                    case 11
                        plot(x(u),y(u),'cs');
                    case 12
                        plot(x(u),y(u),'ms');
                    case 13
                        plot(x(u),y(u),'ys');
                    case 14
                        plot(x(u),y(u),'ks');
                    case 15
                        plot(x(u),y(u),'rd');
                    case 16
                        plot(x(u),y(u),'gd');
                    case 17
                        plot(x(u),y(u),'bd');
                    case 18
                        plot(x(u),y(u),'cd');
                    case 19
                        plot(x(u),y(u),'md');
                    case 20
                        plot(x(u),y(u),'yd');
                    case 21
                        plot(x(u),y(u),'kd');
                    case 22
                        plot(x(u),y(u),'rp');
                    case 23
                        plot(x(u),y(u),'gp');
                    case 24
                        plot(x(u),y(u),'bp');
                    case 25
                        plot(x(u),y(u),'cp');
                    case 26
                        plot(x(u),y(u),'mp');
                    case 27
                        plot(x(u),y(u),'yp');
                    case 28
                        plot(x(u),y(u),'kp');
                    case 29
                        plot(x(u),y(u),'rh');
                    case 30
                        plot(x(u),y(u),'gh');
                    case 31
                        plot(x(u),y(u),'bh');
                    case 32
                        plot(x(u),y(u),'ch');
                    case 33
                        plot(x(u),y(u),'mh');
                    case 34
                        plot(x(u),y(u),'yh');
                    case 35
                        plot(x(u),y(u),'kh');
                    case 36
                        plot(x(u),y(u),'r+');
                    case 37
                        plot(x(u),y(u),'g+');
                    case 38
                        plot(x(u),y(u),'b+');
                    case 39
                        plot(x(u),y(u),'c+');
                    case 40
                        plot(x(u),y(u),'m+');
                    case 41
                        plot(x(u),y(u),'y+');
                    case 42
                        plot(x(u),y(u),'k+');
                    case 43
                        plot(x(u),y(u),'r*');
                    case 44
                        plot(x(u),y(u),'g*');
                    case 45
                        plot(x(u),y(u),'b*');
                    case 46
                        plot(x(u),y(u),'c*');
                    case 47
                        plot(x(u),y(u),'m*');
                    case 48
                        plot(x(u),y(u),'y*');
                    case 49
                        plot(x(u),y(u),'k*');
                    case 50
                        plot(x(u),y(u),'rx');
                    case 51
                        plot(x(u),y(u),'gx');
                    case 52
                        plot(x(u),y(u),'bx');
                    case 53
                        plot(x(u),y(u),'cx');
                    case 54
                        plot(x(u),y(u),'mx');
                    case 55
                        plot(x(u),y(u),'yx');
                    case 56
                        plot(x(u),y(u),'kx');
                    case 57
                        plot(x(u),y(u),'r^');
                    case 58
                        plot(x(u),y(u),'g^');
                    case 59
                        plot(x(u),y(u),'b^');
                    case 60
                        plot(x(u),y(u),'c^');
                    case 61
                        plot(x(u),y(u),'m^');
                    case 62
                        plot(x(u),y(u),'y^');
                    case 63
                        plot(x(u),y(u),'k^');
                    case 64
                        plot(x(u),y(u),'rv');
                    case 65
                        plot(x(u),y(u),'gv');
                    case 66
                        plot(x(u),y(u),'bv');
                    case 67
                        plot(x(u),y(u),'cv');
                    case 68
                        plot(x(u),y(u),'mv');
                    case 69
                        plot(x(u),y(u),'yv');
                    case 70
                        plot(x(u),y(u),'kv');
                    case 71
                        plot(x(u),y(u),'r>');
                    case 72
                        plot(x(u),y(u),'g>');
                    case 73
                        plot(x(u),y(u),'b>');
                    case 74
                        plot(x(u),y(u),'c>');
                    case 75
                        plot(x(u),y(u),'m>');
                    case 76
                        plot(x(u),y(u),'y>');
                    case 77
                        plot(x(u),y(u),'k>');
                    case 78
                        plot(x(u),y(u),'r<');
                    case 79
                        plot(x(u),y(u),'g<');
                    case 80
                        plot(x(u),y(u),'b<');
                    case 81
                        plot(x(u),y(u),'c<');
                    case 82
                        plot(x(u),y(u),'m<');
                    case 83
                        plot(x(u),y(u),'y<');
                    case 84
                        plot(x(u),y(u),'k<');
                    case 85
                        plot(x(u),y(u),'r|');
                    case 86
                        plot(x(u),y(u),'g|');
                    case 87
                        plot(x(u),y(u),'b|');
                    case 88
                        plot(x(u),y(u),'c|');
                    case 89
                        plot(x(u),y(u),'m|');
                    case 90
                        plot(x(u),y(u),'y|');
                    case 91
                        plot(x(u),y(u),'k|');
                    case 92
                        plot(x(u),y(u),'r_');
                    case 93
                        plot(x(u),y(u),'g_');
                    case 94
                        plot(x(u),y(u),'b_');
                    case 95
                        plot(x(u),y(u),'c_');
                    case 96
                        plot(x(u),y(u),'m_');
                    case 97
                        plot(x(u),y(u),'y_');
                    case 98
                        plot(x(u),y(u),'k_');
                    otherwise
                        plot(x(u),y(u),'ro');  
                end
                hold on;
            end
        end
    end
    for i = 1 : spin_size
        for j = 1 : (i - 1)
            if(data(i,j)~=0)
                plot([x(i),x(j)],[y(i),y(j)]);
                hold on
            end
        end
    end
    axis 'equal';
    title('Final Graph');
end