function res = alpha2test(ss,cuantas)
    %t1 = clock;
    tic;
    img = imread(ss);
    
    layers = size(img,3) - 1; % how many layers should have the image in the analysis (issue with tiff images)
    
    img = img(:,:,1:layers);
    if(layers == 3)
        img = rgb2gray(img);
    end
    
    Nx = size(img,1);
    Ny = size(img,2);
    img2 = zeros(Nx,Ny);
    
    l = 4;
    
    measure = zeros(1,l,1);
    
    %C = cuantas; % how many alphas

    temp = log(1:2:(2*l));
    
    for i = 1:Nx
        for j = 1:Ny % texel                            
                %if(measure(k) == 0) measure(k) == eps; end
            measure(1) = max(max(img(max(i-1,1):min(i+1,Nx),max(j-1,1):min(j+1,Ny))));
            measure(2) = max(max(img(max(i-2,1):min(i+2,Nx),max(j-2,1):min(j+2,Ny))));
            measure(3) = max(max(img(max(i-3,1):min(i+3,Nx),max(j-3,1):min(j+3,Ny))));
            measure(4) = max(max(img(max(i-4,1):min(i+4,Nx),max(j-4,1):min(j+4,Ny))));
            
            % calculo de alfa: pendiente de la recta de ajuste
            p2=[temp;ones(1,l)]'\log(measure)';
            %p2 = polyfit(temp,log(measure),1); % 1: grado uno del polinomio
            img2(i,j) = p2(1,:);
        end        
    end
    maxx = max(img2(:));
    minn = min(img2(:));
    
    paso = (maxx-minn)/cuantas;
    clases = (minn:paso:maxx-paso);
    toc;
          
    tic;
    % amount of texels between alpha and the next alpha
    function cant = contar(block,c) 
        cant = 0;
        alpha = clases(c);
        alpha1 = alpha;
        if(c ~= cuantas)
            alpha1 = clases(c+1);
        else
            alpha1 = alpha+1; % any number greater than alpha
        end
        
        s1 = size(block,1);
        s2 = size(block,2);
        
        if(c ~= cuantas)
            for w = 1:s1,
                for t = 1:s2,
                    b = block(w,t);
                    if (b >= alpha && b < alpha1)
                        cant = 1;
                    end
                    if(cant == 1) break; end
                end
                if(cant == 1) break; end
            end
            %c1 = block >= alpha;
            %c2 = block < alpha1;
            %c = (c1+c2) == 2;
        else
            for w = 1:s1,
                for t = 1:s2,
                    if(block(w,t) == alpha1)
                        cant = 1;
                    end
                    if(cant == 1) break; end
                end
            if(cant == 1) break; end
            end
        end
    end

    falpha = zeros(cuantas,1);
    cant = floor(log(Nx));

    res = [];
    
    tic;
    for c = 1:cuantas % one fractal dimension for each c
        
        delta = zeros(1,cant+1,1);
        N = zeros(1,cant+1,1);
        
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
                        flag(i,j) = contar(img2(xStart:Nx, yStart:yEnd),c) || contar(img2(1:dx, yStart:yEnd),c);
                    elseif dx <= 0 && dy > 0,
                        flag(i,j) = contar(img2(xStart:xEnd, yStart:Ny),c) || contar(img2(xStart:xEnd, 1:dy),c);
                    elseif dx > 0 && dy > 0,
                        flag(i,j) = contar(img2(xStart:Nx, yStart:Ny),c)  || contar(img2(1:dx, yStart:Ny),c) || contar(img2(xStart:Nx, 1:dy),c) || contar(img2(1:dx, 1:dy),c);
                    elseif dx <= 0 && dy <= 0, % todo el bloque esta en la grilla
                        flag(i,j) = contar(img2(xStart:xEnd, yStart:yEnd),c); %mark this if ANY part of block is true
                    end

                end
            end

            delta(k+1)    = sizeBlocks;
            N(k+1)    = nnz(flag);
            if(N(k+1) == 0) N(k+1) = eps; end
        end

        p2=[log(delta);ones(1,cant+1,1)]'\log(N)';
        %p2 = polyfit(log(delta),log(N),1); % 1: degree 1 of the polynom
        falpha(c) = -p2(1,:);
        %if((isnan(falpha(c)) || isinf(falpha(c)))) falpha(c) = 0; end
        res = [res, clases(c), falpha(c)];
    end
    toc;
    %res = [clases falpha];
end

