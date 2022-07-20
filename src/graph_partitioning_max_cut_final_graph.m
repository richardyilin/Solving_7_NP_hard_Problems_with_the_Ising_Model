function graph_partitioning_max_cut_final_graph(data,size,spin)
    f = figure;
    R = 1;
    alf=linspace(pi/2,5/2*pi,size+1);
    x = R*cos(alf);
    y = R*sin(alf);
    for i = 1 : size
        if(spin(i,1) == 1)
            plot(x(i),y(i),'ro');
            hold on;
        else
            plot(x(i),y(i),'bd');
            hold on;
        end
    end
    for i = 1 : size
        for j = 1 : (i-1)
            if(spin(i,1) ~= spin(j,1) && data(i,j)~=0)
                plot([x(i),x(j)],[y(i),y(j)]);
                hold on;
            end
        end
    end
    axis 'equal';
    title('Final Graph');
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