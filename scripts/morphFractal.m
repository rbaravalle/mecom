% performs Morphological fractal measuerment over an image
function m = morphologicalFractal(ss)
   
    img = white(ss);
    
    Nx = size(img,1);
    Ny = size(img,2);
    
    maxEps = 7;
    
    for eps = 1:maxEps
        % we use an diamond as structuring element
        se = strel('diamond',eps);
        erodedI = imerode(img,se);
        dilatedI = imdilate(img,se);
        
        sum = 0;
        
        for i = 1:Nx
            for j = 1:Ny
                sum = sum + dilatedI(i,j) - erodedI(i,j);
            end
        end
        
        sum = sum/2*eps;        
        
        s(eps) = sum;        
        
    end
    
    p2 = polyfit(log(1:maxEps),log(double(s)),1); % 1: grado uno del polinomio
    df = p2(:,1);
    
    m = df;
end