% return the image binarised using white's algorithm (local threshold)
function ret = white(ss)
    
    % load up original image and convert to gray-scale
    img = imread(ss);
    %img = img(:,:,1:3);
    
    % parameters
    bias = 1;
    thresh = 0.8;
    vent = 5;
    
    Nx = size(img,1);
    Ny = size(img,2);
    
    %img = rgb2gray(img);
    im = zeros(Nx,Ny);
    
    intImg = zeros(Nx,Ny);
    img = im2double(img);
    
    % summed area table, useful for speed up the computation by adding image pixels
    intImg = im2double(intImg);    
    intImg(1,1) = img(1,1);
    
    for h = 2:Nx,
        intImg(h,1) = intImg(h-1,1) + img(h,1);
    end
    
    for w = 2:Ny,
        intImg(1,w) = intImg(1,w-1) + img(1,w);
    end
    
    for f = 2:Nx,
        for g = 2:Ny,
            intImg(f,g) = img(f,g)+intImg(f-1,g)+intImg(f,g-1)-intImg(f-1,g-1);
        end
    end
    
    % returns the sum of image pixels in the box between
    % (x1,y1) and (x2,y2)
    function res = mww(x1,y1,x2,y2),
        sum = intImg(x2,y2)-intImg(x1,y2)-intImg(x2,y1)+intImg(x1,y1);
        res = sum/((x2-x1+1)*(y2-y1+1));
    end

    % otsu's algorithm
    gt = graythresh(img);

    for i = 1:Nx,
        for j = 1:Ny,
            x1 = i - vent;
            y1 = j - vent;
            if(x1 < 1),
                x1 = 1;
            end            
            if(y1 < 1),
                y1 = 1;
            end
            
            x2 = i + vent;
            y2 = j + vent;
            
            if(x2 > Nx),
                x2 = Nx;
            end
            
            if(y2 > Ny),
                y2 = Ny;
            end
            
            if(mww(x1,y1,x2,y2) >= img(i,j)*bias || img(i,j) < gt*thresh),
                im(i,j) = 255;
            end
        end
    end
    
    % open operation to eliminate small entities in the image
    element = strel('square',2);
    ret = imdilate(imerode(im,element),element);
    
end

