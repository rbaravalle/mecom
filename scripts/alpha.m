function res = alpha(ss,cuantas)
    %t1 = clock;

    img = imread(ss);
    img = rgb2gray(img);
    
    Nx = size(img,1);
    Ny = size(img,2);
    img2 = [];
    
    l = 4;%floor(log(Nx));
    
    e = zeros(1,2,1);
    measure = zeros(1,2,1);
    
    maxx = -1000;
    minn = 1000;
    
%    tam = 8;
    
    C = cuantas;%floor(log(Nx/8)); % cantidad de Clases

    for i = 1:Nx,
        for j = 1:Ny, % texel
            
            for k = 1:l, % boxes centrados en el pixel
                x0 = i - k; % extremo izquierdo
                x1 = i + k;
                y0 = j - k;
                y1 = j + k;
                
                if( x0 < 1 ) x0 = 1;
                end
                if( y0 < 1 ) y0 = 1;
                end
                if( x1 > Nx ) x1 = Nx;
                end
                if( y1 > Ny ) y1 = Ny;
                end
                    
                sum = 0.0; % measure (sum)
                for u = x0:x1,
                    for v = y0:y1, % texel
                        %sum = sum + img(u,v);
                        if(img(u,v) > sum) sum = img(u,v); end;
                    end
                end       
                measure(k) = sum;
                
            end
            
            % calculo de alfa: pendiente de la recta de ajuste
            p2 = polyfit(log(1:l),log(measure),1); % 1: grado uno del polinomio
            alpha = p2(:,1);
            img2(i,j) = alpha;
            
            if(alpha > maxx) maxx = alpha; end
            if(alpha < minn) minn = alpha; end
        end        
    end
       
    clases = []; % clases para calcular f(alpha)
    for c = 1:C,
        clases(c) = minn + (c-1)*(maxx-minn)/C; 
    end
          
    
    function cant = contar(block,c) % cantidad de texels con el valor entre alpha y alpha siguiente
        cant = 0;
        alpha = clases(c);
        alpha1 = alpha;
        if(c ~= C)
            alpha1 = clases(c+1);
        end
        
        s1 = size(block,1);
        s2 = size(block,2);
        for w = 1:s1,
            for t = 1:s2,
                b = block(w,t);
                if(c ~= C)
                    if (b >= alpha && b < alpha1)
                        cant = 1;
                    end
                else
                    if(b == alpha1)
                        cant = 1;
                    end
                end
                if(cant == 1) break; end
            end
            if(cant == 1) break; end
        end
    end

    falpha = [];
    cant = floor(log(Nx));

    n = 0;
    for c = 1:C-1, % una dim fractal por cada c
        delta = [];
        numBlocks = [];
        for k = 0:cant, % cambiar por tamanio!!!!
            numBlocks = power(2,k);
            sizeBlocks_x = floor(Nx./numBlocks);
            sizeBlocks_y = floor(Ny./numBlocks);

            flag = zeros(numBlocks,numBlocks);

            boxCount = 0;

            for i = 1:numBlocks
                for j = 1:numBlocks
                    xStart = (i-1)*sizeBlocks_x + 1;
                    xEnd   = i*sizeBlocks_x;
                    yStart = (j-1)*sizeBlocks_y + 1;
                    yEnd   = j*sizeBlocks_y;

                    block = img2(xStart:xEnd, yStart:yEnd);
                    flag(i,j) = contar(block,c); % si algun alfa esta dentro del bloque
                end
            end
            boxCount = nnz(flag);

            delta(k+1)    = numBlocks;
            N(k+1)    = boxCount;
        end

        p2 = polyfit(log(delta),log(N),1); % 1: grado uno del polinomio
        falpha(c) = p2(:,1);
        if((isnan(falpha(c)) || isinf(falpha(c)))) falpha(c) = 0; end
    end
    
    %res = etime(clock,t1);
    
    res = falpha;
end

