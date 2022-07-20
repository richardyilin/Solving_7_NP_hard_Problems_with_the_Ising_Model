function third_difference = calculate_third_difference(spin, data, size, v, j, plus)
    third_difference = 0;
    if(j > 1 && j < size)
        for ver = 1 : size %cancel the punishment j-1 to j{           
            if (spin(ver,j+1) && ~data(v,ver)) % spin[v][j]  is xuj
                if (plus)
                    third_difference = third_difference + 1;
                else
                    third_difference = third_difference - 1;
                end
            end
            if (spin(ver,j-1) && ~data(ver,v)) %spin[v][j]  is x v j+1
                if (plus)
                    third_difference = third_difference + 1;
                else
                    third_difference = third_difference - 1;
                end 
            end
        end
    elseif(j == size)
        for ver = 1 : size % cancel the punishment j-1 to j
            if (spin(ver,1) && ~data(v,ver)) % spin[v][j]  is xuj
                if (plus)
                    third_difference = third_difference + 1;
                else
                    third_difference = third_difference - 1;
                end                
            end
            if (spin(ver,size-1) && ~data(ver,v)) %spin[v][j]  is x v j+1
                if (plus)
                    third_difference = third_difference + 1;
                else
                    third_difference = third_difference - 1;
                end    
            end
        end
    else
        for ver = 1 : size % cancel the punishment j-1 to j
            if (spin(ver,2) && ~data(v,ver)) % spin[v][j]  is xuj
                if (plus)
                    third_difference = third_difference + 1;
                else
                    third_difference = third_difference - 1;
                end    
            end
            if (spin(ver,size) && ~data(ver,v)) %spin[v][j]  is x v j+1
                if (plus)
                    third_difference = third_difference + 1;
                else
                    third_difference = third_difference - 1;
                end
            end 
        end                        
    end 
end