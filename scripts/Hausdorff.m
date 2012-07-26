function [hdf,x,y] = hausdorff(ss)
    %table =[,2];

    % load up original image and convert to gray-scale
    %img = imread(ss);
    %img = rgb2gray(img);
    
    e2 = white(ss); %segmentation

    figure(2)
    imshow(e2)

    function e = esta(x,a)
       s = size(a);
       s = s(2);
       e = 0;
       for k = 1:s,
            if a(k) == x,
                e = 1;   
                break;
            end
       end
    end
    
    Nx = size(e2,1);
    Ny = size(e2,2);
    h = 1;
    
    for i = 0:9,
        numBlocks = power(2,i);
        sizeBlocks_x = floor(Nx./numBlocks);
        sizeBlocks_y = floor(Ny./numBlocks);
        
        %if sizeBlocks_x >= 1 && sizeBlocks_y >= 1,

            flag = zeros(numBlocks,numBlocks);

            posx = []; % posiciones al azar
            posy = []; % posiciones al azar

            if sizeBlocks_x > 1 && numBlocks>1,
                cant = min(sizeBlocks_x,4); % como maximo 16 (4x4) 

                for j = 1:cant,
                   val = floor(rand*sizeBlocks_x);
                   while(esta(val,posx)),
                       val = floor(rand*sizeBlocks_x);
                   end
                   posx = [posx,val];

                   val = floor(rand*sizeBlocks_x);
                   while(esta(val,posy)),
                       val = floor(rand*sizeBlocks_x);
                   end
                   posy = [posy,val];
                end

                boxCount = 0;
                for c1 = 1:cant, % promedio de casos
                    for c2 = 1:cant, % promedio de casos
                        for i = 1:numBlocks
                            for j = 1:numBlocks
                                xStart = posx(c1)+(i-1)*sizeBlocks_x + 1;
                                xEnd   = posx(c1)+i*sizeBlocks_x;

                                yStart = posy(c2)+(j-1)*sizeBlocks_y + 1;
                                yEnd   = posy(c2)+j*sizeBlocks_y;

                                dx = xEnd - Nx; % sobrante en pixeles en x
                                dy = yEnd - Ny; % sobrante en pixeles en y
                                if dx > 0 && dy <= 0,
                                    block1 = e2(xStart:Nx, yStart:yEnd);
                                    block2 = e2(1:dx, yStart:yEnd);
                                    flag(i,j) = any(block1(:)) || any(block2(:));
                                end

                                if dx <= 0 && dy > 0,
                                    block1 = e2(xStart:xEnd, yStart:Ny);
                                    block2 = e2(xStart:xEnd, 1:dy);
                                    flag(i,j) = any(block1(:)) || any(block2(:));
                                end

                                if dx > 0 && dy > 0,
                                    block1 = e2(xStart:Nx, yStart:Ny);
                                    block2 = e2(1:dx, yStart:Ny);
                                    block3 = e2(xStart:Nx, 1:dy);
                                    block4 = e2(1:dx, 1:dy);

                                    flag(i,j) = any(block1(:)) || any(block2(:)) || any(block3(:)) || any(block4(:));
                                end

                                if dx <= 0 && dy <= 0, % todo el bloque esta en la grilla
                                    block = e2(xStart:xEnd, yStart:yEnd);
                                    flag(i,j) = any(block(:)); %mark this if ANY part of block is true
                                end
                            end
                        end
                        boxCount = boxCount + nnz(flag);
                    end
                end
                boxCount = floor(boxCount/(cant*cant)); % promedio de casos
            else
                for i = 1:numBlocks
                    for j = 1:numBlocks
                        xStart = (i-1)*sizeBlocks_x + 1;
                        xEnd   = i*sizeBlocks_x;

                        yStart = (j-1)*sizeBlocks_y + 1;
                        yEnd   = j*sizeBlocks_y;

                        block = e2(xStart:xEnd, yStart:yEnd);
                        flag(i,j) = any(block(:)); %mark this if ANY part of block is true
                    end
                end
                boxCount = nnz(flag);
            end

            if(boxCount ~= 0),
                delta(h)    = numBlocks; %numBlocks; (1/delta)
                N(h)    = boxCount;
                h = h+1;
            end
       % end
    end

    %cftool(log(delta), log(N));
    
    p2 = polyfit(log(delta),log(N),1); % 1: grado uno del polinomio   
    hdf = p2(:,1)
    x = log(delta);
    y = log(N);
end

