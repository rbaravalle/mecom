function [res,x,y] = alpha2(ss,cuantas)
    %t1 = clock;

    img = imread(ss);
    img = rgb2gray(img);
    
    Nx = size(img,1);
    Ny = size(img,2);
    img2 = zeros(Nx,Ny);
    
    l = 4;%floor(log(Nx));
    
    e = zeros(1,2,1);
    measure = zeros(1,2,1);
    
    maxx = -1000;
    minn = 1000;
    
    C = cuantas; % how many alphas

    for i = 1:Nx,
        for j = 1:Ny, % texel
            
            for k = 1:l, % boxes centered at the pixel
                x0 = i - k;
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
            p2 = polyfit(log(1:2:(2*l)),log(measure),1); % 1: grado uno del polinomio
            alpha = p2(:,1);
            img2(i,j) = alpha;
            
            if(alpha > maxx) maxx = alpha; end
            if(alpha < minn) minn = alpha; end
        end        
    end
       
    clases = zeros(C,1); % clases para calcular f(alpha)
    for c = 1:C,
        clases(c) = minn + (c-1)*(maxx-minn)/C; 
    end
          
    
    % amount of texels between alpha and the next alpha
    function cant = contar(block,c) 
        cant = 0;
        alpha = clases(c);
        alpha1 = alpha;
        if(c ~= C)
            alpha1 = clases(c+1);
        else
            alpha1 = alpha+1; % any number greater than alpha
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

    falpha = zeros(C,1);
    cant = floor(log(Nx));

    %n = 0;
    for c = 1:C % one fractal dimension for each c
        delta = zeros(cant,1);
        N = zeros(cant,1);
        
        for k = 0:cant
            sizeBlocks = 2*k+1;
            numBlocks_x = ceil(Nx/sizeBlocks);
            numBlocks_y = ceil(Ny/sizeBlocks);

            flag = zeros(numBlocks_x,numBlocks_y);

            for i = 1:numBlocks_x
                for j = 1:numBlocks_y
                    xStart = (i-1)*sizeBlocks + 1;
                    xEnd   = i*sizeBlocks;
                    yStart = (j-1)*sizeBlocks + 1;
                    yEnd   = j*sizeBlocks;
                    
                    dx = xEnd - Nx; % leftovers pixels in x
                    dy = yEnd - Ny; % leftovers en pixeles en y
                    if dx > 0 && dy <= 0,
                        block1 = img2(xStart:Nx, yStart:yEnd);
                        block2 = img2(1:dx, yStart:yEnd);
                        flag(i,j) = contar(block1,c) || contar(block2,c);
                    end

                    if dx <= 0 && dy > 0,
                        block1 = img2(xStart:xEnd, yStart:Ny);
                        block2 = img2(xStart:xEnd, 1:dy);
                        flag(i,j) = contar(block1,c) || contar(block2,c);
                    end

                    if dx > 0 && dy > 0,
                        block1 = img2(xStart:Nx, yStart:Ny);
                        block2 = img2(1:dx, yStart:Ny);
                        block3 = img2(xStart:Nx, 1:dy);
                        block4 = img2(1:dx, 1:dy);

                        flag(i,j) = contar(block1,c) || contar(block2,c) || contar(block3,c) || contar(block4,c);
                    end

                    if dx <= 0 && dy <= 0, % todo el bloque esta en la grilla
                        block = img2(xStart:xEnd, yStart:yEnd);
                        flag(i,j) = contar(block,c); %mark this if ANY part of block is true
                    end

                end
            end
            boxCount = nnz(flag);

            delta(k+1)    = sizeBlocks;
            N(k+1)    = boxCount;
        end

        p2 = polyfit(log(delta),log(N),1); % 1: degree 1 of the polynom
        falpha(c) = -p2(:,1);
        if((isnan(falpha(c)) || isinf(falpha(c)))) falpha(c) = 0; end
    end
    
    %res = etime(clock,t1);
    cftool(clases,falpha);
    res = falpha;%[clases; falpha];
    x = clases;
    y = falpha;
end

