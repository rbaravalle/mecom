lactalNFSa = [];

ult = 0;

N = 20;

for i = 1:N,
    %namesLC{i} = strcat('panMarco/lactal/l',int2str(i+ult),'.tif');
    namesSaC{i} = strcat('panMarco/sandwich/s',int2str(i+ult),'.tif');
end

%sandwich = [];
%max1 = -100;
%max2 = -100;
for i = 1:N
    lactalNFSa = [lactalNFSa; mca(namesSaC{i}) ];
    %lactalNFC = [lactalNF; mca(namesL{i}) ];
    %sandwichNFC = [sandwichNF; mca(namesSa{i}) ];
    %salvadoNFC = [salvadoNF; mca(namesS{i}) ];
end
