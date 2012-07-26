% estimates the values to initialise the particle system
function vals = particles_parameters(ss)

    im = white(ss);
    im=bwlabel(im,4);    

    S = imfeature(im,'Area');
    
    areas = []; 
    
    for i=1:size(S), areas=[areas,S(i).Area]; end

    [kmres, centers] = kmeans(areas, 3, 'EmptyAction', 'singleton');
    
    kres = sort(hist(kmres));
    sizkres = size(kres,2);
    
    kres = [kres(sizkres-2) kres(sizkres-1) kres(sizkres)]; %last three components of kres
    
    vals = [sort(kres,'descend');sort(centers','ascend')];
end