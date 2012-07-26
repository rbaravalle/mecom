% return the image binarised fuzzy (local threshold)
function ret = fuzzy2(ss)
    
    % max Gray Level
    maxGL = 255;
    
    % load up original image and convert to gray-scale
    img = imread(ss);
        
    Nx = size(img,1);
    Ny = size(img,2);
    
    img = rgb2gray(img);

    
    function res = histogram(im)
        res = zeros(maxGL+1,1);
        for i = 1:Nx,
            for j = 1:Ny,
                val = im(i,j);
                res(val+1) = res(val+1) + 1;
            end
        end
    end

    h = histogram(img);
    plot(h);
    %img = double(img); 

    % calculate the sum between b and l
    function mu = mu_internal(b,l)
        sum = 0;       
        mu = 0;
        for i=b+1:l+1,
            sum = sum + h(i);
            mu = mu + i*h(i);
        end
        if(sum == 0)
            mu = 0;
        else
            mu = mu / sum;
        end
    end

    % u0
    function mu0 = mu0(t)
        mu0 = mu_internal(0,t);
    end

    % u1
    function mu1 = mu1(t)
        mu1 = mu_internal(t+1,maxGL);
    end

    prim = 0;
    ult = 0;
    maxbin = 255;
    minbin = 0;
    for i = 0:maxGL
        if(h(i+1) > 0)
            minbin = i;
            break;
        end            
    end
    for i = maxGL:0
        if(h(i+1) > 0)
            maxbin = i;
            break;
        end            
    end

    C = 1/(maxbin-minbin);
    topt = -1;
    minim = 2000000;
    function f = fuzziness()
        for t = 0:maxGL
            sum = 0;
            m0 = mu0(t);
            m1 = mu1(t);
            for j = 0:t
                muIJ = 1 / (1 + C*abs(j-m0));
                if(not(((muIJ  < 1e-06 ) || ( muIJ > 0.999999))))
                    s = h(j+1)*(-muIJ*log(muIJ) - (1-muIJ)*(log(1-muIJ)));
                    sum = sum + s;
                end
            end
            for j = t+1:maxGL
                muIJ = 1 / (1 + C*abs(j-m1));
                if(not(((muIJ  < 1e-06 ) || ( muIJ > 0.999999))))
                    s = h(j+1)*(-muIJ*log(muIJ) - (1-muIJ)*(log(1-muIJ)));
                    sum = sum + s;
                end
            end
            if(sum < minim)
                minim = sum;
                topt = t;
            end            
        end
        f = topt;
    end

    fuzz = fuzziness();
    
    imshow(img < fuzz);
    
    ret = fuzz;
    
end

