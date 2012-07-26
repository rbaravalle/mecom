function res = promParameters()
   
    N = 50;
    
    for i = 1:50,
        namesB{i} = strcat('panScanner/corte/baguette',int2str(i),'.jpg');
        namesL{i} = strcat('panScanner/corte/lactal',int2str(i),'.jpg');
        namesS{i} = strcat('panScanner/corte/salvado',int2str(i),'.jpg');
        namesSa{i} = strcat('panScanner/corte/sandwich',int2str(i),'.jpg');
    end
    
    a = zeros(2,3);
    b = zeros(2,3);
    c = zeros(2,3);
    d = zeros(2,3);
    
    for i = 1:50
        a = a + particles_parameters(namesB{i});
        b = b + particles_parameters(namesL{i});
        c = c + particles_parameters(namesS{i});
        d = d + particles_parameters(namesSa{i});
    end
    
    res = [a/N b/N c/N d/N];
end