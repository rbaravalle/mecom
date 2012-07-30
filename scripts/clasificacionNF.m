
N= 50;

%names = {};
namesSa = {};
namesL = {};

ult = 0;

SaM = [];
LM = [];
BM = [];
SM = [];

%for i = 1:50
%name{i} = strcat('panScanner/corte/sandwich',int2str(i),'.jpg');
%SaM(i) = morphFractal(name{i}); end

%for i = 1:50
%name{i} = strcat('panScanner/corte/lactal',int2str(i),'.jpg');
%LM(i) = morphFractal(name{i}); end

%for i = 1:50
%name{i} = strcat('panScanner/corte/baguette',int2str(i),'.jpg');
%BM(i) = morphFractal(name{i}); end

%for i = 1:50
%name{i} = strcat('panScanner/corte/salvado',int2str(i),'.jpg');
%SM(i) = morphFractal(name{i}); end
if(0)
baguetteNF = [];
salvadoNF = [];
lactalNF = [];
sandwichNF = [];


baguetteNFC = [];
salvadoNFC = [];
lactalNFC = [];
sandwichNFC = [];

alliedNF = [];
odlumsNF = [];
shiptonsNF = [];
ursulaNFC = [];
end

    if(0)
        imagenesNF = [];
direc = '/home/rodrigo/mecom2012/amcastyle/mecom2/mecom/exps/100sample/';
archivos = dir(direc)

    for i = 3:size(archivos,1),
       namesIm{i} = strcat(direc,archivos(i).name);
    end
    
    for i = 3:size(archivos,1),
        if(size(imread(namesIm{i}),3) == 3) % if it is RGB
            imagenesNF = [imagenesNF; mca(namesIm{i}) ];
        end
    end

    imagenesNF = imagenesNF(:,4:6);
    
    for i = 1:50,
        namesB{i} = strcat('panScanner/corte/baguette',int2str(i+ult),'.tif');
        namesL{i} = strcat('panScanner/corte/lactal',int2str(i+ult),'.tif');
        namesS{i} = strcat('panScanner/corte/salvado',int2str(i+ult),'.tif');
        namesSa{i} = strcat('panScanner/corte/sandwich',int2str(i+ult),'.tif');
        %namesU{i} = strcat('dublin/ursula/u',int2str(i+ult),'.tif');        
    end
    
    for i = 1:20,
        namesBC{i} = strcat('panMarco/baguette/b',int2str(i+ult),'.tif');
        namesLC{i} = strcat('panMarco/lactal/l',int2str(i+ult),'.tif');
        namesSC{i} = strcat('panMarco/salvado/s',int2str(i+ult),'.tif');
        namesSaC{i} = strcat('panMarco/sandwich/s',int2str(i+ult),'.tif');
        %namesA{i} = strcat('dublin/allied',int2str(i+ult),'.tif');
        %namesO{i} = strcat('dublin/odlums',int2str(i+ult),'.tif');
        %namesSh{i} = strcat('dublin/shiptons',int2str(i+ult),'.tif');
        %namesAC{i} = strcat('dublin/camera/allied/allied',int2str(i+ult),'c.tif');
        
    end
    end
    
    if(0)

        
    for i = 1:50,
        namesB{i} = strcat('panScanner/corte/baguette',int2str(i+ult),'.tif');
        namesL{i} = strcat('panScanner/corte/lactal',int2str(i+ult),'.tif');
        namesS{i} = strcat('panScanner/corte/salvado',int2str(i+ult),'.tif');
        namesSa{i} = strcat('panScanner/corte/sandwich',int2str(i+ult),'.tif');
        %namesU{i} = strcat('dublin/ursula/u',int2str(i+ult),'.tif');        
    end
    end
    %sandwich = [];
    %max1 = -100;
    %max2 = -100;
    if(0)
    for i = 1:50
        baguetteNF = [baguetteNF; mca(namesB{i}) ];
        lactalNF = [lactalNF; mca(namesL{i}) ];
        sandwichNF = [sandwichNF; mca(namesSa{i}) ];
        salvadoNF = [salvadoNF; mca(namesS{i}) ];
    end
    end
        
    if(0)
    for i = 1:20
        
        baguetteNFC = [baguetteNFC; mca(namesBC{i}) ];
        lactalNFC = [lactalNFC; mca(namesLC{i}) ];
        sandwichNFC = [sandwichNFC; mca(namesSaC{i}) ];
        salvadoNFC = [salvadoNFC; mca(namesSC{i}) ];
        %alliedNF = [alliedNF; mca(namesA{i}) ];
        %odlumsNF = [odlumsNF; mca(namesO{i}) ];
        %shiptonsNF = [shiptonsNF; mca(namesSh{i}) ];
        %ursulaNFC = [ursulaNFC; mca(namesAC{i}) ];
    end
    end
    
    if(0)
    means = zeros(3,4,1);
    stdevs = zeros(3,4,1);

    for i = 1:3
        means(i,1) = mean(baguetteNF(:,i));
        means(i,2) = mean(lactalNF(:,i));
        means(i,3) = mean(salvadoNF(:,i));
        means(i,4) = mean(sandwichNF(:,i));
        stdevs(i,1) = std(baguetteNF(:,i));
        stdevs(i,2) = std(lactalNF(:,i));
        stdevs(i,3) = std(salvadoNF(:,i));
        stdevs(i,4) = std(sandwichNF(:,i));
    end
    

    % scaling
    
    b = baguetteNF;
    l = lactalNF;
    s = salvadoNF;
    sa = sandwichNF;
    
    %% sizes
B  = size(b,1);
L  = size(l,1);
S  = size(s,1);
Sa = size(sa,1);

%% labels
%label = zeros(B+L+S+Sa,1);

%label(1:B,1) = 1;
%label(B+1:B+L,1) = 2;
%label(B+L+1:B+L+S,1) = 3;
%label(B+L+S+1:B+L+S+Sa,1) = 4;

labeltrain = [];
labeltest = [];

labeltrain(1:20,1) = 1;
labeltrain(21:40,1) = 2;
labeltrain(41:60,1) = 3;
labeltrain(61:80,1) = 4;
labeltrain(81:100,1) = 5;

labeltest(1:20,1) = 1;
labeltest(21:40,1) = 2;
labeltest(41:60,1) = 3;
labeltest(61:80,1) = 4;
labeltest(81:100,1) = 5;

    end
%% label2name
% label2name{1} = 'baguette';
% label2name{2} = 'lactal';
% label2name{3} = 'salvado';
% label2name{4} = 'sandwich';

%% features
%datatrain = [baguetteNF; lactalNF; salvadoNF; sandwichNF];
%datatest = [baguetteNFC; lactalNFC; salvadoNFC; sandwichNFC];

%ursulaNF = [alliedNF; odlumsNF; shiptonsNF(1:10,:)];




if(0) %prueba 2) Fractal
datatrain = [baguette(1:20,:); lactal(1:20,:); salvado(1:20,:); sandwich(1:20,:)];
datatrain = [datatrain; imagenes(1:20,:)];

datatest = [baguetteC(1:20,:); lactalC(1:20,:); salvadoC(1:20,:); sandwichC(1:20,:)]
datatest = [datatest; imagenes(21:40,:)];

labelClasif = [];
labeltestClasif = [];

labelClasif(1:20,1) = 1;
labelClasif(21:40,1) = 2;
labelClasif(41:60,1) = 3;
labelClasif(61:80,1) = 4;
labelClasif(81:100,1) = 5;

labeltestClasif(1:20,1) = 1;
labeltestClasif(21:40,1) = 2;
labeltestClasif(41:60,1) = 3;
labeltestClasif(61:80,1) = 4;
labeltestClasif(81:100,1) = 5;

%clasificadorNF = [[baguetteNF(1:20,:); baguetteNFC(1:20,:)]; [lactalNF(1:20,:); lactalNFC(1:20,:)]; [salvadoNF(1:20,:); salvadoNFC(1:20,:)]; [sandwichNF(1:20,:); sandwichNFC(1:20,:)]];

%clasificadorNF = [clasificadorNF(:,4:6); imagenesNF(1:40,:)];
libsvmwrite( 'train2_clasificador.txt' , labelClasifNF, sparse(datatrain) );

%labeltestClasifNF(1:23,1) = 5;

libsvmwrite( 'test2_clasificador.txt' , labeltestClasifNF, sparse(datatest) );
end

if(0) %prueba 2)
datatrain = [baguetteNF(1:20,:); lactalNF(1:20,:); salvadoNF(1:20,:); sandwichNF(1:20,:)];
datatrain = [datatrain(:,4:6); imagenesNF(1:20,:)];

datatest = [baguetteNFC(1:20,:); lactalNFC(1:20,:); salvadoNFC(1:20,:); sandwichNFC(1:20,:)]
datatest = [datatest(:,4:6); imagenesNF(21:40,:)];

labelClasifNF = [];
labeltestClasifNF = [];

labelClasifNF(1:20,1) = 1;
labelClasifNF(21:40,1) = 2;
labelClasifNF(41:60,1) = 3;
labelClasifNF(61:80,1) = 4;
labelClasifNF(81:100,1) = 5;

labeltestClasifNF(1:20,1) = 1;
labeltestClasifNF(21:40,1) = 2;
labeltestClasifNF(41:60,1) = 3;
labeltestClasifNF(61:80,1) = 4;
labeltestClasifNF(81:100,1) = 5;

%clasificadorNF = [[baguetteNF(1:20,:); baguetteNFC(1:20,:)]; [lactalNF(1:20,:); lactalNFC(1:20,:)]; [salvadoNF(1:20,:); salvadoNFC(1:20,:)]; [sandwichNF(1:20,:); sandwichNFC(1:20,:)]];

%clasificadorNF = [clasificadorNF(:,4:6); imagenesNF(1:40,:)];
libsvmwrite( 'train2_clasificadorNF.txt' , labelClasifNF, sparse(datatrain) );

%labeltestClasifNF(1:23,1) = 5;

libsvmwrite( 'test2_clasificadorNF.txt' , labeltestClasifNF, sparse(datatest) );
end


if(1) %prueba 1)
datatrain = [baguetteNF(1:50,:); lactalNF(1:50,:); salvadoNF(1:50,:); sandwichNF(1:50,:)];
datatrain = [datatrain(:,4:6); imagenesNF(1:50,1:3)];

%datatest = [baguetteNFC(1:20,:); lactalNFC(1:20,:); salvadoNFC(1:20,:); sandwichNFC(1:20,:)]
%datatest = [datatest(:,4:6); imagenesNF(21:40,:)];

%labelClasifNF = [];
%labeltestClasifNF = [];

labelClasif(1:50,1) = 1;
labelClasif(51:100,1) = 2;
labelClasif(101:150,1) = 3;
labelClasif(151:200,1) = 4;
labelClasif(201:250,1) = 5;

%labeltestClasifNF(1:20,1) = 1;
%labeltestClasifNF(21:40,1) = 2;
%labeltestClasifNF(41:60,1) = 3;
%labeltestClasifNF(61:80,1) = 4;
%labeltestClasifNF(81:100,1) = 5;

%clasificadorNF = [[baguetteNF(1:20,:); baguetteNFC(1:20,:)]; [lactalNF(1:20,:); lactalNFC(1:20,:)]; [salvadoNF(1:20,:); salvadoNFC(1:20,:)]; [sandwichNF(1:20,:); sandwichNFC(1:20,:)]];

%clasificadorNF = [clasificadorNF(:,4:6); imagenesNF(1:40,:)];
libsvmwrite( 'train_prueba1NF.txt' , labelClasif, sparse(datatrain) );

%labeltestClasifNF(1:23,1) = 5;

%libsvmwrite( 'test2_clasificadorNF.txt' , labeltestClasifNF, sparse(datatest) );
end

if(0) %clasificador posta
datatrain = [[baguette(1:20,:); baguetteC]; [lactal(1:20,:); lactalC]; [salvado(1:20,:); salvadoC]; [sandwich(1:20,:); sandwichC]];
datatrain = [datatrain; imagenes(1:40,:)];

%datatest = [baguetteNFC(1:20,:); lactalNFC(1:20,:); salvadoNFC(1:20,:); sandwichNFC(1:20,:)]
%datatest = [datatest(:,4:6); imagenesNF(21:40,:)];

%labelClasifNF = [];
%labeltestClasifNF = [];

labelClasif(1:40,1) = 1;
labelClasif(41:80,1) = 2;
labelClasif(81:120,1) = 3;
labelClasif(121:160,1) = 4;
labelClasif(161:200,1) = 5;

%labeltestClasifNF(1:20,1) = 1;
%labeltestClasifNF(21:40,1) = 2;
%labeltestClasifNF(41:60,1) = 3;
%labeltestClasifNF(61:80,1) = 4;
%labeltestClasifNF(81:100,1) = 5;

%clasificadorNF = [[baguetteNF(1:20,:); baguetteNFC(1:20,:)]; [lactalNF(1:20,:); lactalNFC(1:20,:)]; [salvadoNF(1:20,:); salvadoNFC(1:20,:)]; [sandwichNF(1:20,:); sandwichNFC(1:20,:)]];

%clasificadorNF = [clasificadorNF(:,4:6); imagenesNF(1:40,:)];
libsvmwrite( 'train_clasificadorPosta.txt' , labelClasif, sparse(datatrain) );

%labeltestClasifNF(1:23,1) = 5;

%libsvmwrite( 'test2_clasificadorNF.txt' , labeltestClasifNF, sparse(datatest) );
end


if(0) % prueba 3)
datatrain = [baguetteNF(1:40,:); lactalNF(1:40,:); salvadoNF(1:40,:); sandwichNF(1:40,:)];
datatrain = [datatrain(:,4:6); imagenesNF(1:40,:)];

datatest = [baguetteNFC(1:20,:); lactalNFC(1:20,:); salvadoNFC(1:20,:); sandwichNFC(21:40,:)]
datatest = [datatest(:,4:6); imagenesNF(41:60,:)];

labelClasifNF(1:40,1) = 1;
labelClasifNF(41:80,1) = 2;
labelClasifNF(81:120,1) = 3;
labelClasifNF(121:160,1) = 4;
labelClasifNF(161:200,1) = 5;

labeltestClasifNF(1:20,1) = 1;
labeltestClasifNF(21:40,1) = 2;
labeltestClasifNF(41:60,1) = 3;
labeltestClasifNF(61:80,1) = 4;
labeltestClasifNF(81:100,1) = 5;

%clasificadorNF = [[baguetteNF(1:20,:); baguetteNFC(1:20,:)]; [lactalNF(1:20,:); lactalNFC(1:20,:)]; [salvadoNF(1:20,:); salvadoNFC(1:20,:)]; [sandwichNF(1:20,:); sandwichNFC(1:20,:)]];

%clasificadorNF = [clasificadorNF(:,4:6); imagenesNF(1:40,:)];
libsvmwrite( 'train_clasificadorNF.txt' , labelClasifNF, sparse(datatrain) );

%labeltestClasifNF(1:23,1) = 5;

libsvmwrite( 'test_clasificadorNF.txt' , labeltestClasifNF, sparse(datatest) );
end

%clasificador = [[baguette(1:20,:); baguetteC(1:20,:)]; [lactal(1:20,:); lactalC(1:20,:)]; [salvado(1:20,:); salvadoC(1:20,:)]; [sandwich(1:20,:); sandwichC(1:20,:)]];

if(0)
clasificador = [baguette(1:40,:); lactal(1:40,:); salvado(1:40,:); sandwich(1:40,:)];


labelClasif(1:40,1) = 1;
labelClasif(41:80,1) = 2;
labelClasif(81:120,1) = 3;
labelClasif(121:160,1) = 4;
labelClasif(161:200,1) = 5;

clasificador = [clasificador; imagenes(1:40,:)];
libsvmwrite( 'train_clasificador.txt' , labelClasif, sparse(clasificador) );

%labeltestClasif(1:5,1) = 5;
labeltestClasif(1:20,1) = 1;
labeltestClasif(21:40,1) = 2;
labeltestClasif(41:60,1) = 3;
labeltestClasif(61:80,1) = 4;
labeltestClasif(81:100,1) = 5;
test = [baguetteC; lactalC; salvadoC; sandwichC; imagenes(1:20,:)];

libsvmwrite( 'test_clasificador.txt' , labeltestClasif, sparse(test) );
end

if(0)
    fakesNF = [];
direc = '/home/rodrigo/mecom2012/amcastyle/mecom2/mecom/exps/fake/';
archivos = dir(direc)

    for i = 3:size(archivos,1),
       namesIm{i} = strcat(direc,archivos(i).name);
    end
    
    for i = 3:size(archivos,1),
        if(size(imread(namesIm{i}),3) == 3) % if it is RGB
            fakesNF = [fakesNF; mca(namesIm{i}) ];
        end
    end

    fakesNF = fakesNF(:,4:6);
     
end

if(0)
    fakes = [];
direc = '/home/rodrigo/mecom2012/amcastyle/mecom2/mecom/exps/fake/';
archivos = dir(direc)

    for i = 3:size(archivos,1),
       namesIm{i} = strcat(direc,archivos(i).name);
    end
    
    for i = 3:size(archivos,1),
        if(size(imread(namesIm{i}),3) == 3) % if it is RGB
            fakes = [fakes; morphFractal(namesIm{i}), Hausdorff(namesIm{i}), alpha2test(namesIm{i},20) ];
        end
    end     
end
%datatest = [imagenesNF(1:80,:)];

%%
%libsvmwrite( 'train_rodrigoFa.txt' , labeltrain, sparse(datatrain) );
%libsvmwrite( 'test_rodrigoNF5.txt' , labeltest, sparse(datatest) );
    
    
%b = TreeBagger(50,vS,names,'OOBPred','on','NVarToSample',10)
%predict