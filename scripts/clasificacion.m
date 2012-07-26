
N= 12;

%names = {};
namesSa = {};
namesL = {};

ult = 38;

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

    for i = 1:N,
        %namesB{i} = strcat('panScanner/corte/baguette',int2str(i+ult),'.jpg');
        %namesS{i} = strcat('panScanner/corte/salvado',int2str(i+ult),'.jpg');
        namesS{i} = strcat('panScanner/corte/salvado',int2str(i+ult),'.jpg');
        %namesSa{i} = strcat('panScanner/corte/sandwich',int2str(i+ult),'.jpg');
    end

    %sandwich = [];
    for i = 1:N,
        %vres = [vres; Hausdorff(namesB{i}), transpose(alpha2(namesB{i},20))];
        %vres = [vres; Hausdorff(namesS{i}), transpose(alpha2(namesS{i},20))];
        %sandwich = [sandwich; Hausdorff(namesSa{i}), transpose(alpha2(namesSa{i},20))];
        salvado = [salvado; Hausdorff(namesS{i}), transpose(alpha2(namesS{i},20))];
    end
end
%b = TreeBagger(50,vS,names,'OOBPred','on','NVarToSample',10)
%predict