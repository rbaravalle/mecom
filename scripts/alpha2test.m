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
                %v = img(i,j);
            measure(1) = max(max(img(max(i-1,1):min(i+1,Nx),max(j-1,1):min(j+1,Ny))));
            measure(2) = max(max(img(max(i-2,1):min(i+2,Nx),max(j-2,1):min(j+2,Ny))));
            measure(3) = max(max(img(max(i-3,1):min(i+3,Nx),max(j-3,1):min(j+3,Ny))));
            measure(4) = max(max(img(max(i-4,1):min(i+4,Nx),max(j-4,1):min(j+4,Ny))));
            %measure(5) = max(max(img(max(i-5,1):min(i+5,Nx),max(j-5,1):min(j+5,Ny))));
            
            %if(measure(1) == 0) measure(1) = eps; end
            %if(measure(2) == 0) measure(2) = eps; end
            %if(measure(3) == 0) measure(3) = eps; end
            %if(measure(4) == 0) measure(4) = eps; end
            
            % calculo de alfa: pendiente de la recta de ajuste
            p2=[temp;ones(1,l)]'\log(measure+1)';
            %p2 = polyfit(temp,log(measure),1); % 1: grado uno del polinomio
            img2(i,j) = p2(1,:);
        end        
    end
    %figure,imtool(img2);
    
    %%
    maxx = max(img2(:));
    minn = min(img2(:));
    
    paso = (maxx-minn)/cuantas;
    clases = (minn:paso:maxx-paso);
    toc;
          
    %tic;
    % amount of texels between alpha and the next alpha
    %function cant = contar(block,c) 
        %cant = 0;
        %alpha = clases(c);
        %alpha1 = alpha;
        %if(c ~= cuantas)
        %    alpha1 = clases(c+1);
        %else
        %    alpha1 = alpha+1; % any number greater than alpha
        %end
        
        %s1 = size(block,1);
        %s2 = size(block,2);
        
       %cant = ((c == cuantas) && (sum(sum(block == clases(c+1))) > 0)) || (sum(sum((block >=  clases(c))))+sum(sum((block <  clases(c)+1))) == 2);
        
        %if(c ~= cuantas)
            %for w = 1:s1,
            %    for t = 1:s2,
            %        b = block(w,t);
            %        if (b >= alpha && b < alpha1)
            %            cant = 1;
            %        end
            %        if(cant == 1) break; end
            %    end
            %    if(cant == 1) break; end
            %end
        %else
            %for w = 1:s1,
            %    for t = 1:s2,
            %        if(block(w,t) == alpha1)
            %            cant = 1;
            %        end
            %        if(cant == 1) break; end
            %    end
            %if(cant == 1) break; end
            %end
        %end
    %end

    falpha = zeros(1,cuantas);
    cant = floor(log(Nx));

    %res = [];
    
    tic;
        
    img2 = [img2 img2; img2 img2];
    for c = 1:cuantas % one fractal dimension for each c
        %tic;
        N = zeros(1,cant+1,1);
        
        for k = 0:cant
            sizeBlocks = 2*k+1;
            numBlocks_x = ceil(Nx/sizeBlocks);
            numBlocks_y = ceil(Ny/sizeBlocks);

            flag = zeros(numBlocks_x,numBlocks_y);

            for i = 1:numBlocks_x
                for j = 1:numBlocks_y
                    
                    block = img2((i-1)*sizeBlocks + 1:i*sizeBlocks, (j-1)*sizeBlocks + 1:j*sizeBlocks);
                    
                    f = 0;
                    %alpha = clases(c);
                    %alpha1 = alpha;
                    %if(c ~= cuantas)
                    %    alpha1 = clases(c+1);
                    %else
                    %    alpha1 = alpha+1; % any number greater than alpha
                    %end
                    s1 = size(block,1);
                    s2 = size(block,2);

                    %cant = ((c == cuantas) && (sum(sum(block == clases(c+1))) > 0)) || (sum(sum((block >=  clases(c))))+sum(sum((block <  clases(c)+1))) == 2);
                    if(c ~= cuantas)
                        for w = 1:s1,
                            for t = 1:s2,
                                b = block(w,t);
                                if (b >= clases(c) && b < clases(c+1))
                                   f = 1;
                                end
                                if(f == 1) break; end
                            end
                            if(f == 1) break; end
                        end
                    else
                        for w = 1:s1,
                            for t = 1:s2,
                                if(block(w,t) == clases(c)+1)
                                    f = 1;
                                end
                                if(f == 1) break; end
                            end
                        if(f == 1) break; end
                        end
                    end
                    flag(i,j) = f;
                                       
                    %if(c == cuantas)
                    %    flag(i,j) = (sum(sum(block == clases(c)+1)) > 0);
                    %else
                    %    flag(i,j) = (sum(sum((block >=  clases(c))))+sum(sum((block <  clases(c+1)))) == 2);
                    %end
                    %flag(i,j) = contar(img2((i-1)*sizeBlocks + 1:i*sizeBlocks, (j-1)*sizeBlocks + 1:j*sizeBlocks),c); %mark this if ANY part of block is true
                end
            end
            N(k+1)    = nnz(flag);
            %toc;
        end

        p2=[log((0:cant)*2+1);ones(1,cant+1,1)]'\log(N+1)';
        falpha(c) = -p2(1,:);
        %res = [res, clases(c), falpha(c)];
        %toc;
    end
    %res = [clases/(]
    %toc;
    res = [clases falpha];
    toc;
end

