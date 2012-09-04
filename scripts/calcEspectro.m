
baguetteC = [];
salvadoC = [];
lactalC = [];
sandwichC = [];


baguette = [];
salvado = [];
lactal = [];
sandwich = [];

for i = 1:20,       
    namesB{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/scanner/baguette/baguette',int2str(i+ult),'.tif');
    namesL{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/scanner/lactal/lactal',int2str(i+ult),'.tif');
    namesS{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/scanner/salvado/salvado',int2str(i+ult),'.tif');
    namesSa{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/scanner/sandwich/sandwich',int2str(i+ult),'.tif');

    namesBC{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/camera/baguette/b',int2str(i+ult),'.tif');
    namesLC{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/camera/lactal/l',int2str(i+ult),'.tif');
    namesSC{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/camera/salvado/s',int2str(i+ult),'.tif');
    namesSaC{i} = strcat('/home/rodrigo/mecom2012/mecom/imagenes/camera/sandwich/s',int2str(i+ult),'.tif');
end

for i = 1:20
    baguette = [baguette; alpha2test(namesB{i},20)];
    lactal = [lactal; alpha2test(namesL{i},20)];
    salvado = [salvado; alpha2test(namesS{i},20)];
    sandwich = [sandwich; alpha2test(namesSa{i},20)];


    baguetteC = [baguetteC; alpha2test(namesBC{i},20)];
    lactalC = [lactalC; alpha2test(namesLC{i},20)];
    salvadoC = [salvadoC; alpha2test(namesSC{i},20)];
    sandwichC = [sandwichC; alpha2test(namesSaC{i},20)];

end

%% calculo imagenes caltech

imagenes3 = [];
direc = '/home/rodrigo/mecom2012/mecom/exps/100sample/res/';
archivos = dir(direc)

namesIm = {}

for i = 3:size(archivos,1)
   namesIm{i} = strcat(direc,archivos(i).name);
end

for i = 3:size(archivos,1),
    if(size(imread(namesIm{i}),3) == 3) % if it is RGB
        imagenes3 = [imagenes3; alpha2test(namesIm{i},20) ];
    end
end

fractal2SumS = [baguette; lactal; salvado; sandwich; imagenes3(1:20,:)];
fractal2SumC = [baguetteC; lactalC; salvadoC; sandwichC; imagenes3(21:40,:)];

%data = [baguette; lactal; salvado; sandwich; imagenes3(1:20,:)];
csvwrite('fractal2SumS.csv',fractal2SumS);
csvwrite('fractal2SumC.csv',fractal2SumC);
labels(1:20) = 1;
labels(21:40) = 2;
labels(41:60) = 3;
labels(61:80) = 4;
labels(81:100) = 5;
libsvmwrite('fractal2SumC.txt',labels',sparse(fractal2SumC));
libsvmwrite('fractal2SumS.txt',labels',sparse(fractal2SumS));
