
N= 20;

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
baguette = [];
salvado = [];
lactal = [];
sandwich = [];
allied = [];
shiptons = [];
odlums = [];
ranks = [];

baguetteC = [];
salvadoC = [];
lactalC = [];
sandwichC = [];
alliedC = [];
shiptonsC = [];
odlumsC = [];
ranksC = [];
ursulaC = [];
end

if(1)
    imagenes3 = [];
%imagenes = [];
direc = '/home/rodrigo/mecom2012/mecom/exps/100sample/res/';
archivos = dir(direc)

    for i = 3:size(archivos,1)
       namesIm{i} = strcat(direc,archivos(i).name);
    end
    
    for i = 3:size(archivos,1),
        if(size(imread(namesIm{i}),3) == 3) % if it is RGB
            imagenes3 = [imagenes3; morphFractal(namesIm{i}), Hausdorff(namesIm{i}), alpha2test(namesIm{i},20) ];
        end
    end
end
if(0)

    for i = 1:N,
        namesB{i} = strcat('panScanner/corte/baguette',int2str(i+ult),'.tif');
        namesL{i} = strcat('panScanner/corte/lactal',int2str(i+ult),'.tif');
        namesS{i} = strcat('panScanner/corte/salvado',int2str(i+ult),'.tif');
        namesSa{i} = strcat('panScanner/corte/sandwich',int2str(i+ult),'.tif');
        namesOdlums{i} = strcat('dublin/odlum',int2str(i+ult),'.tif');
        namesRanks{i} = strcat('dublin/ranks',int2str(i+ult),'.tif');
        namesBC{i} = strcat('panMarco/baguette/b',int2str(i+ult),'.tif');
        namesUC{i} = strcat('dublin/camera/allied/allied',int2str(i+ult),'c.tif');
        %namesSC{i} = strcat('panMarco/salvado/s',int2str(i+ult),'.tif');
        %namesLC{i} = strcat('panMarco/lactal/l',int2str(i+ult),'.tif');
    end

    %sandwich = [];
    for i = 1:N
        %baguette = [baguette; morphFractal(namesSa{i}), Hausdorff(namesB{i}), alpha2test(namesB{i},20)];
        %lactal = [lactal; morphFractal(namesSa{i}), Hausdorff(namesL{i}), alpha2test(namesL{i},20)];
        %sandwich = [sandwich; morphFractal(namesSa{i}), Hausdorff(namesSa{i}), alpha2test(namesSa{i},20)];
        %salvado = [salvado; morphFractal(namesS{i}), Hausdorff(namesS{i}), alpha2test(namesS{i},20)];
        %allied = [allied; morphFractal(namesAllied{i}), Hausdorff(namesAllied{i}), alpha2test(namesAllied{i},20)];
        %shiptons = [shiptons; morphFractal(namesShiptons{i}), Hausdorff(namesShiptons{i}), alpha2test(namesShiptons{i},20)];
        %odlums = [odlums; morphFractal(namesOdlums{i}), Hausdorff(namesOdlums{i}), alpha2test(namesOdlums{i},20)];
        %ranks = [ranks; morphFractal(namesRanks{i}), Hausdorff(namesRanks{i}), alpha2test(namesRanks{i},20)];
        %baguetteC = [baguetteC; morphFractal(namesBC{i}), Hausdorff(namesBC{i}), alpha2test(namesBC{i},20)];
        %salvadoC = [C; morphFractal(namesBC{i}), Hausdorff(namesBC{i}), alpha2test(namesBC{i},20)];
        %salvadoC = [salvadoC; morphFractal(namesSC{i}), Hausdorff(namesSC{i}), alpha2test(namesSC{i},20)];
        %lactalC = [lactalC; morphFractal(namesLC{i}), Hausdorff(namesLC{i}), alpha2test(namesLC{i},20)];
        ursulaC = [ursulaC; morphFractal(namesUC{i}), Hausdorff(namesUC{i}), alpha2test(namesUC{i},20)];
    end
end

%sandwichC = [];

if(0)

    for i = 1:20,
        %namesLC{i} = strcat('panMarco/lactal/l',int2str(i+ult),'.tif');
        namesLSa{i} = strcat('panMarco/sandwich/s',int2str(i+ult),'.tif');
    end

    %sandwich = [];
    for i = 1:20
        %lactalC = [lactalC; morphFractal(namesLC{i}), Hausdorff(namesLC{i}), alpha2test(namesLC{i},20)];
        sandwichC = [sandwichC; morphFractal(namesLSa{i}), Hausdorff(namesLSa{i}), alpha2test(namesLSa{i},20)];
    end
end
%b = TreeBagger(50,vS,names,'OOBPred','on','NVarToSample',10)
%predict