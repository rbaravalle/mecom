
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

if(1)
baguette = [];
salvado = [];
lactal = [];
sandwich = [];
baguetteNF = [];
salvadoNF = [];
lactalNF = [];
sandwichNF = [];
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


if(0)

    for i = 1:N,
        %namesOdlums{i} = strcat('dublin/odlum',int2str(i+ult),'.tif');
        %namesRanks{i} = strcat('dublin/ranks',int2str(i+ult),'.tif');
        %namesBC{i} = strcat('panMarco/baguette/b',int2str(i+ult),'.tif');
        %namesBCS{i} = strcat('/home/rodrigo/panMarco/baguette/corteSlicer/b',int2str(i+ult),'.tif');
        %namesUC{i} = strcat('dublin/camera/allied/allied',int2str(i+ult),'c.tif');
        %namesSC{i} = strcat('panMarco/salvado/s',int2str(i+ult),'.tif');
        %namesLC{i} = strcat('panMarco/lactal/l',int2str(i+ult),'.tif');
    end

    %sandwich = [];
    for i = 1:N
        namesB{i} = strcat('imagenes/scanner/baguette/baguette',int2str(i+ult),'.tif');
        namesL{i} = strcat('imagenes/scanner/lactal/lactal',int2str(i+ult),'.tif');
        namesS{i} = strcat('imagenes/scanner/salvado/salvado',int2str(i+ult),'.tif');
        namesSa{i} = strcat('imagenes/scanner/sandwich/sandwich',int2str(i+ult),'.tif');
        
%         baguette = [baguette; morphFractal(namesSa{i}), Hausdorff(namesB{i}), alpha2test(namesB{i},20)];
%         lactal = [lactal; morphFractal(namesSa{i}), Hausdorff(namesL{i}), alpha2test(namesL{i},20)];
%         sandwich = [sandwich; morphFractal(namesSa{i}), Hausdorff(namesSa{i}), alpha2test(namesSa{i},20)];
%         salvado = [salvado; morphFractal(namesS{i}), Hausdorff(namesS{i}), alpha2test(namesS{i},20)];
        baguette = [baguette; morphFractal(namesSa{i}), Hausdorff(namesB{i}), multifractal(namesB{i})];
        lactal = [lactal; morphFractal(namesSa{i}), Hausdorff(namesL{i}), multifractal(namesL{i})];
        sandwich = [sandwich; morphFractal(namesSa{i}), Hausdorff(namesSa{i}), multifractal(namesSa{i})];
        salvado = [salvado; morphFractal(namesS{i}), Hausdorff(namesS{i}), multifractal(namesS{i})];
        %allied = [allied; morphFractal(namesAllied{i}), Hausdorff(namesAllied{i}), alpha2test(namesAllied{i},20)];
        %shiptons = [shiptons; morphFractal(namesShiptons{i}), Hausdorff(namesShiptons{i}), alpha2test(namesShiptons{i},20)];
        %odlums = [odlums; morphFractal(namesOdlums{i}), Hausdorff(namesOdlums{i}), alpha2test(namesOdlums{i},20)];
        %ranks = [ranks; morphFractal(namesRanks{i}), Hausdorff(namesRanks{i}), alpha2test(namesRanks{i},20)];
        %baguetteCS = [baguetteCS; morphFractal(namesBCS{i}), Hausdorff(namesBCS{i}), alpha2test(namesBCS{i},20)];
        %salvadoC = [C; morphFractal(namesBC{i}), Hausdorff(namesBC{i}), alpha2test(namesBC{i},20)];
        %salvadoC = [salvadoC; morphFractal(namesSC{i}), Hausdorff(namesSC{i}), alpha2test(namesSC{i},20)];
        %lactalC = [lactalC; morphFractal(namesLC{i}), Hausdorff(namesLC{i}), alpha2test(namesLC{i},20)];
        %ursulaC = [ursulaC; morphFractal(namesUC{i}), Hausdorff(namesUC{i}), alpha2test(namesUC{i},20)];
        %baguetteNF = [baguetteNF; mca(namesB{i}) ];
        %lactalNF = [lactalNF; mca(namesL{i}) ];
        %sandwichNF = [sandwichNF; mca(namesSa{i}) ];
        %salvadoNF = [salvadoNF; mca(namesS{i}) ];
    end
    csvwrite('panes.csv',[baguette; lactal; salvado; sandwich]);

end

if(1)
    imagenes3 = [];
    direc = '/home/rodrigo/mecom2012/mecom/exps/100sample/res/';
    archivos = dir(direc)

    
    for i = 3:size(archivos,1),
        namesIm = '';
        namesIm = strcat(direc,archivos(i).name);
        if(size(imread(namesIm),3) == 3) % if it is RGB
            imagenes3 = [imagenes3; multifractal(namesIm)];
        end
    end
end


if(0)
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
    data = [baguette; lactal; salvado; sandwich; imagenes3(1:50,:)];
    csvwrite('fractal.csv',[baguette; lactal; salvado; sandwich; imagenes3(1:50,:)]);
    labels(1:50) = 1;
    labels(51:100) = 2;
    labels(101:150) = 3;
    labels(151:200) = 4;
    labels(201:250) = 5;
    libsvmwrite('fractal.txt',labels,data);
end

%baguetteCS = [];
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


if(1)

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

    %sandwich = [];
    for i = 1:20
        %lactalC = [lactalC; morphFractal(namesLC{i}), Hausdorff(namesLC{i}), alpha2test(namesLC{i},20)];
        baguette = [baguette; multifractal(namesB{i})];
        lactal = [lactal; multifractal(namesL{i})];
        salvado = [salvado; multifractal(namesS{i})];
        sandwich = [sandwich; multifractal(namesSa{i})];
        
        
        baguetteC = [baguetteC; multifractal(namesBC{i})];
        lactalC = [lactalC; multifractal(namesLC{i})];
        salvadoC = [salvadoC; multifractal(namesSC{i})];
        sandwichC = [sandwichC; multifractal(namesSaC{i})];
        
    end
    
    
    fractal2otroS = [baguette; lactal; salvado; sandwich; imagenes3(1:20,:)];
    fractal2otroC = [baguetteC; lactalC; salvadoC; sandwichC; imagenes3(21:40,:)];

    csvwrite('fractal2otroS.csv',fractal2otroS);
    csvwrite('fractal2otroC.csv',fractal2otroC);
    
    libsvmwrite('fractal2otroS.txt',labels',sparse(fractal2otroS));
    libsvmwrite('fractal2otroC.txt',labels',sparse(fractal2otroC));
    
    fractal2s = csvread('/home/rodrigo/mecom2012/mecom/exps/fractal2s.csv');
    fractal2c = csvread('/home/rodrigo/mecom2012/mecom/exps/fractal2c.csv');

    fractal2Es = [fractal2s fractal2otroS];
    fractal2Ec = [fractal2c fractal2otroC];

    csvwrite('fractal2Es.csv',fractal2Es);
    csvwrite('fractal2Ec.csv',fractal2Ec);

    libsvmwrite('fractal2Es.txt',labels',sparse(fractal2Es));
    libsvmwrite('fractal2Ec.txt',labels',sparse(fractal2Ec));
    
end



%b = TreeBagger(50,vS,names,'OOBPred','on','NVarToSample',10)
%predict