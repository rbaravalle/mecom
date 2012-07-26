% Classifies the test set using multi class SVm's (method one-versus-all)
function [outputNames,r] = svmTest(train,names,test,gtruth)

    namesLactal = {};
    namesSalvado = {};
    namesSandwich = {};
    namesBaguette = {};
    
    N = size(train);
    N = N(1);
    
    % Four SVMs, Test is the same for all SVM's
    % Lactal - Not Lactal
    for i=1:N
        if(strcmp(names{i},'lactal') == 1)
            namesLactal{i} = 'lactal';
        else
            namesLactal{i} = 'no';
        end
    end
    svmL = svmtrain(train,namesLactal,'autoscale','false');
    [resL,scoresL] = svmclassify(svmL,test);

    % Salvado - Not Salvado
    for i=1:N
        if(strcmp(names{i},'salvado') == 1)
            namesSalvado{i} = 'salvado';
        else
            namesSalvado{i} = 'no';
        end
    end
    svmS = svmtrain(train,namesSalvado,'autoscale','false');
    [resS,scoresS] = svmclassify(svmS,test);

    % Sandwich - Not Sandwich
    for i=1:N
        if(strcmp(names{i},'sandwich') == 1)
            namesSandwich{i} = 'sandwich';
        else
            namesSandwich{i} = 'no';
        end
    end
    svmSa = svmtrain(train,namesSandwich,'autoscale','false');
    [resSa,scoresSa] = svmclassify(svmSa,test);

    % Baguette - Not Baguette
    for i=1:N
        if(strcmp(names{i},'baguette') == 1)
            namesBaguette{i} = 'baguette';
        else
            namesBaguette{i} = 'no';
        end
    end
    svmB = svmtrain(train,namesBaguette,'autoscale','false');
    [resB,scoresB] = svmclassify(svmB,test);

    M = size(gtruth);
    M = M(1);
    
    for i = 1:M
        outputScores(i) = 1000;
        outputNames{i} = 'nothing';
    end
    
    % the class of the object is the max output of the classifiers
    for i = 1:M
        if(scoresL(i) < outputScores(i) && strcmp(resL{i},'no') == 0)
            outputScores(i) = scoresL(i);            
            outputNames{i} = resL{i};
        end
        if(scoresS(i) < outputScores(i) && strcmp(resS{i},'no') == 0)
            outputScores(i) = scoresS(i);            
            outputNames{i} = resS{i};
        end
        if(scoresSa(i) < outputScores(i) && strcmp(resSa{i},'no') == 0)
            outputScores(i) = scoresSa(i);            
            outputNames{i} = resSa{i};
        end
        if(scoresB(i) < outputScores(i) && strcmp(resB{i},'no') == 0)
            outputScores(i) = scoresB(i);            
            outputNames{i} = resB{i};
        end
    end
    
    r = sum(strcmp(outputNames',gtruth));
    %r = sum(res)/M; % Result: effectiveness % of the method
end