% crumb features
function crumb = mca(ss)

    function res = h(d)
        s1 = size(d,1);
        s2 = size(d,2);
        res = zeros(256,1,1);
        for w = 1:s1
            for u = 1:s2
                res(d(w,u)+1) = res(d(w,u)+1) +1;
            end
        end
    end

    im = white(ss);
    
    Nx = size(im,1);
    Ny = size(im,2);
    siz = Nx*Ny;
    
    im=bwlabel(im,4);    

    S = imfeature(im,'Area');
    
    vals = []; 
    
    for j=1:size(S), vals=[vals,S(j).Area]; end
    
    suma = sum(vals); % total area of the cells
    
    m = mean(vals); % mean
    stdev = std(vals); % std deviation
    VF = suma/siz;
        
    % Color information
    im2 = imread(ss);
    r = im2(:,:,1:1);
    g = im2(:,:,2:2);
    b = im2(:,:,3:3);
    r = mean(mean(r));
    g = mean(mean(g));
    b = mean(mean(b));
    
    crumb = [m,stdev,VF,r,g,b];
end
