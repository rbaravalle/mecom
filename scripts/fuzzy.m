% return the image binarised fuzzy (local threshold)
function ret = fuzzy(ss)
    
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
        mu = mu / sum;
    end

    % u0
    function mu0 = mu0(t)
        mu0 = mu_internal(0,t);
    end

    % u1
    function mu1 = mu1(t)
        mu1 = mu_internal(t+1,maxGL);
    end
    
       
    function muI = muI(t)
        % C: constant such that 0.5 <= muI(f(x,y)) <= 1
        C = 0.0;
        muI = zeros(Nx,Ny);
        %muI = double(muI);
        m0 = mu0(t);
        m1 = mu1(t);
        for i = 1:Nx,
            for j = 1:Ny,
                val = img(i,j);
                m = 0;
                if (val <= t)
                    m = m0;
                else
                    m = m1;
                end
                dist = abs(double(val)-m);
                muI(i,j) = dist;
                if(dist > C)
                    C = dist;
                end
            end
        end
        C = C*20;
        for i = 1:Nx,
            for j = 1:Ny,
                % we use the information in muI(i,j) to alleviate calculations
                v = 1.0/(1.0+muI(i,j)/C);
                if(v < 0.5 || v > 1) 
                    error('Uxy not in range!');
                end
                muI(i,j) = v;
            end
        end
    end
      
    function f = fuzziness(t)
        imF = muI(t);
        sum = 0;
        for i = 1:Nx,
            for j = 1:Ny,
                muIJ = double(imF(i,j));
                %S(uI(i,j))
                s = -muIJ*log(muIJ) - (1-muIJ)*(log(1-muIJ));
                sum = sum + s;
            end
        end
        f = sum; %(1/(Nx*Ny*log(2)))*sum;
    end

    base = 0;
    top = 255;
    minim = fuzziness(base);
    minimT = base;
    fuzzA = [];
    for k = base+1:top,
        fuzz = fuzziness(k);
        if(fuzz < minim)
            minim = fuzz;
            minimT = k;
        end
        fuzzA(k-base) = fuzz;
    end;

    % optimal threshold calculated
    topt = minimT;
    ret = topt;
    
end

