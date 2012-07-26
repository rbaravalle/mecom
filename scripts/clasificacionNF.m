
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

baguetteNF = [];
salvadoNF = [];
lactalNF = [];
sandwichNF = [];



baguetteNFC = [];
salvadoNFC = [];
lactalNFC = [];
sandwichNFC = [];

    for i = 1:50,
        namesB{i} = strcat('panScanner/corte/baguette',int2str(i+ult),'.tif');
        namesL{i} = strcat('panScanner/corte/lactal',int2str(i+ult),'.tif');
        namesS{i} = strcat('panScanner/corte/salvado',int2str(i+ult),'.tif');
        namesSa{i} = strcat('panScanner/corte/sandwich',int2str(i+ult),'.tif');
        
    end
    
    for i = 1:20,
        namesBC{i} = strcat('panMarco/baguette/b',int2str(i+ult),'.tif');
        namesLC{i} = strcat('panMarco/lactal/l',int2str(i+ult),'.tif');
        namesSC{i} = strcat('panMarco/salvado/s',int2str(i+ult),'.tif');
        namesSaC{i} = strcat('panMarco/sandwich/s',int2str(i+ult),'.tif');
        
    end

    %sandwich = [];
    max1 = -100;
    max2 = -100;
    for i = 1:50
        baguetteNF = [baguetteNF; mca(namesB{i}) ];
        lactalNF = [lactalNF; mca(namesL{i}) ];
        sandwichNF = [sandwichNF; mca(namesSa{i}) ];
        salvadoNF = [salvadoNF; mca(namesS{i}) ];
    end
    for i = 1:20
        
        baguetteNFC = [baguetteNFC; mca(namesBC{i}) ];
        lactalNFC = [lactalNFC; mca(namesLC{i}) ];
        sandwichNFC = [sandwichNFC; mca(namesSaC{i}) ];
        salvadoNFC = [salvadoNFC; mca(namesSC{i}) ];
    end
    
    
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
label = zeros(B+L+S+Sa,1);

label(1:B,1) = 1;
label(B+1:B+L,1) = 2;
label(B+L+1:B+L+S,1) = 3;
label(B+L+S+1:B+L+S+Sa,1) = 4;

labeltrain(1:50,1) = 1;
labeltrain(51:100,1) = 2;
labeltrain(101:150,1) = 3;
labeltrain(151:200,1) = 4;

labeltest(1:20,1) = 1;
labeltest(21:40,1) = 2;
labeltest(41:60,1) = 3;
labeltest(61:80,1) = 4;


%% label2name
% label2name{1} = 'baguette';
% label2name{2} = 'lactal';
% label2name{3} = 'salvado';
% label2name{4} = 'sandwich';

%% features
%datatrain = [baguetteNF; lactalNF; salvadoNF; sandwichNF];
%datatest = [baguetteNFC; lactalNFC; salvadoNFC; sandwichNFC];

datatrain = [baguetteNF; lactalNF; salvadoNF; sandwichNF];
datatest = [baguetteNFC; lactalNFC; salvadoNFC; sandwichNFC];

%%
libsvmwrite( 'train_rodrigo.txt' , labeltrain, sparse(datatrain) );
libsvmwrite( 'test_rodrigo.txt' , labeltest, sparse(datatest) );
    
%b = TreeBagger(50,vS,names,'OOBPred','on','NVarToSample',10)
%predict