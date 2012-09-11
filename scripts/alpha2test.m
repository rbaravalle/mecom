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
    
    measure = zeros(Ny,l);
    
    %C = cuantas; % how many alphas

    temp = log(1:2:(2*l));
       
    for i = 1:Nx
        for j = 1:Ny % texel                            
            measure(j,1,i) = max(max(img(max(i-1,1):min(i+1,Nx),max(j-1,1):min(j+1,Ny))));
            measure(j,2,i) = max(max(img(max(i-2,1):min(i+2,Nx),max(j-2,1):min(j+2,Ny))));
            measure(j,3,i) = max(max(img(max(i-3,1):min(i+3,Nx),max(j-3,1):min(j+3,Ny))));
            measure(j,4,i) = max(max(img(max(i-4,1):min(i+4,Nx),max(j-4,1):min(j+4,Ny))));
        end        
    end
    %toc;
    for i = 1:Nx       
        AA=kron(speye(Ny), [temp;ones(1,l)]');
        yvalues = log(measure(:,:,i)+1)';

        bb=yvalues; bb=bb(:);
        z=AA\bb;
        z=reshape(z,2,[]);
        img2(i,:)=z(1,:)'; 
    end
    %toc;
    %tic;
    
    %%
    maxx = max(img2(:));
    minn = min(img2(:));
    
    paso = (maxx-minn)/cuantas;
    clases = (minn:paso:maxx-paso);
          
    falpha = zeros(1,cuantas);
    cant = floor(log(Nx));

    %% falpha imagen
        
    img2 = [img2 img2; img2 img2];
    for c = 1:cuantas % one fractal dimension for each c
        %tic;
        N = zeros(1,cant+1);
        
        for k = 0:cant
            sizeBlocks = 2*k+1;
            numBlocks_x = ceil(Nx/sizeBlocks);
            numBlocks_y = ceil(Ny/sizeBlocks);

            flag = zeros(numBlocks_x,numBlocks_y);

            for i = 1:numBlocks_x
                for j = 1:numBlocks_y
                    
                   block = img2((i-1)*sizeBlocks + 1:i*sizeBlocks, (j-1)*sizeBlocks + 1:j*sizeBlocks);
                    
                   f = 0;
                   s1 = size(block,1);
                   s2 = size(block,2);

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
                    %    flag(i,j) = (sum(sum((block >=  clases(c)))) > 0) && (sum(sum((block <  clases(c+1)))) > 0);
                    %end
                    N(k+1) = N(k+1) + f; %flag(i,j);
                end
            end
            %toc;
        end

        p2=[log((0:cant)*2+1);ones(1,cant+1,1)]'\log(N+1)';
        falpha(c) = -p2(1,:);
        %toc;
    end
    %toc;
    res = [clases falpha];
    toc;
end

