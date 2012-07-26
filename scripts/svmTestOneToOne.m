% Classifies the test set using multi class SVm's (method one-versus-all)
function [classes,r] = svmTestOneToOne(train,names,test,gtruth, numK, argSigma, autosc)

    namesLS = {}; 
    namesLSa = {}; 
    namesLB = {}; 
    namesSSa = {}; 
    namesSB = {}; 
    namesSaB = {}; 
    
    N = size(train);
    N = N(1);
    
    lactal = [];
    baguette = [];
    salvado = [];
    sandwich = [];
    
    argK = {'linear','quadratic','polynomial','rbf','mlp'};

    
    for i = 1:N
        if(strcmp(names{i},'lactal') == 1)
            lactal = [lactal; train(i,:)];
        end
        if(strcmp(names{i},'baguette') == 1)
            baguette = [baguette; train(i,:)];
        end
        if(strcmp(names{i},'salvado') == 1)
            salvado = [salvado; train(i,:)];
        end
        if(strcmp(names{i},'sandwich') == 1)
            sandwich = [sandwich; train(i,:)];
        end
    end
    
    Sa = size(sandwich);
    Sa = Sa(1);
    
    S = size(salvado);
    S = S(1);
    
    B = size(baguette);
    B = B(1);
    
    L = size(lactal);
    L = L(1);
    
    for i=1:L+S
        if(i<=L)
            namesLS{i} = 'lactal';
        else
            namesLS{i} = 'salvado';
        end
    end
    svmLS = svmtrain([lactal;salvado],namesLS, 'autoscale',autosc, 'kernel_function', argK{numK}, 'rbf_sigma', argSigma);
    
    for i=1:L+Sa
        if(i<=L)
            namesLSa{i} = 'lactal';
        else
            namesLSa{i} = 'sandwich';
        end
    end
    svmLSa = svmtrain([lactal;sandwich],namesLSa, 'autoscale',autosc, 'kernel_function', argK{numK}, 'rbf_sigma', argSigma);
    
    for i=1:L+B
        if(i<=L)
            namesLB{i} = 'lactal';
        else
            namesLB{i} = 'baguette';
        end
    end
    svmLB = svmtrain([lactal;baguette],namesLB, 'autoscale',autosc, 'kernel_function', argK{numK}, 'rbf_sigma', argSigma);
    
    for i=1:S+Sa
        if(i<=S)
            namesSSa{i} = 'salvado';
        else
            namesSSa{i} = 'sandwich';
        end
    end
    svmSSa = svmtrain([salvado;sandwich],namesSSa, 'autoscale',autosc, 'kernel_function', argK{numK}, 'rbf_sigma', argSigma);
    
    for i=1:S+B
        if(i<=S)
            namesSB{i} = 'salvado';
        else
            namesSB{i} = 'baguette';
        end
    end
    svmSB = svmtrain([salvado;baguette],namesSB, 'autoscale',autosc, 'kernel_function', argK{numK}, 'rbf_sigma', argSigma);
    
    for i=1:Sa+B
        if(i<=Sa)
            namesSaB{i} = 'sandwich';
        else
            namesSaB{i} = 'baguette';
        end
    end
    svmSaB = svmtrain([sandwich;baguette],namesSaB, 'autoscale',autosc, 'kernel_function', argK{numK}, 'rbf_sigma', argSigma);
    
    %classify each item in test
    [resLS,a] = svmclassify(svmLS,test);
    [resLSa,a] = svmclassify(svmLSa,test);
    [resLB,a] = svmclassify(svmLB,test);
    [resSSa,a] = svmclassify(svmSSa,test);
    [resSB,a] = svmclassify(svmSB,test);
    [resSaB,a] = svmclassify(svmSaB,test);
    
    T = size(gtruth);
    T = T(1);
    
    % combine all the results
    % first sum...
    %r = T
    %if(0)
    %res = zeros(4:4);
    a = T;
    res = zeros(a,4);
    for i = 1:T
        if(strcmp(resLS{i},'lactal') == 1)
            res(i,1) = res(i,1) + 1;
        else
            res(i,2) = res(i,2) + 1;
        end
        if(strcmp(resLSa{i},'lactal') == 1)
            res(i,1) = res(i,1) + 1;
        else
            res(i,3) = res(i,3) + 1;
        end
        if(strcmp(resLB{i},'lactal') == 1)
            res(i,1) = res(i,1) + 1;
        else
            res(i,4) = res(i,4) + 1;
        end
        if(strcmp(resSSa{i}, 'salvado') == 1)
            res(i,2) = res(i,2) + 1;
        else
            res(i,3) = res(i,3) + 1;
        end
        if(strcmp(resSB{i}, 'salvado') == 1)
            res(i,2) = res(i,2) + 1;
        else
            res(i,4) = res(i,4) + 1;
        end
        if(strcmp(resSaB{i}, 'sandwich') == 1)
            res(i,3) = res(i,3) + 1;
        else
            res(i,4) = res(i,4) + 1;
        end
    end
    %then determine class
    classes = {};
    for i = 1:T
        max = res(i,1);
        maxJ = 1;
        for j = 2:4
            if(res(i,j) > max)
                max = res(i,j);
                maxJ = j;
            end
        end
        if(maxJ == 1)
            classes{i} = 'lactal';
        end
        if(maxJ == 2)
            classes{i} = 'salvado';
        end
        if(maxJ == 3)
            classes{i} = 'sandwich';
        end
        if(maxJ == 4)
            classes{i} = 'baguette';
        end
    end
         
    
    r = sum(strcmp(classes',gtruth));
    %end
    %classes = {};
    %r = T(1);
    %r = sum(res)/M; % Result: effectiveness % of the method
end