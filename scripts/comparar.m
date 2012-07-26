% Rodrigo Baravalle

% compares all the methods showing a graph with errors 
% SVM MultiClass , RandomForests
function v = comparar(b,l,s,sa)

    B = size(b);
    B = B(1);
    
    L = size(l);
    L = L(1);
    
    S = size(s);
    S = S(1);
    
    Sa = size(sa);
    Sa = Sa(1);

    for i = 1:B
        names{i} = 'baguette';
    end
    for i = B+1:B+L
        names{i} = 'lactal';
    end
    for i = B+L+1:B+L+S
        names{i} = 'salvado';
    end
    for i = B+L+S+1:B+L+S+Sa
        names{i} = 'sandwich';
    end

    p1 = [];
    p2 = [];
    p3 = [];
    p4 = [];
    
    inds = [2];
        
    cant = B+L+S+Sa;
    
    for i = 20:20:100
        inds = [inds i];
    end
    
    inds = [inds cant];
    
    % 75% - 25%
    kernel = 1; %kernel for the rbf
    data = [b;l;s;sa];
    
    if(1)
        rf = kfoldCrossValidation(4, 0, data, names', kernel, -3);
        %svm = kfoldCrossValidation(4, 1, data, names', kernel, -3);
        %svm = 1;
        svm = 1; svm1to1 = 1;
        %svm1to1 = kfoldCrossValidation(4, 2, data, names', kernel, -3);
        % try with differents gamma in the rbf kernel
        if(kernel == 4)
            maxx = svm1to1;
            maxind = -3;
            for i = -2:1:4
                svm1to1 = kfoldCrossValidation(4, 2, data, names', kernel, i);
                if(svm1to1 > maxx) maxx = svm1to1; maxind = i; end
            end
            svm1to1 = maxx;
        end
    end
        
    if(0)    
        for i = inds
            p1 = [p1 i];
            % Random Forest
            p2 = [p2 kfoldCrossValidation(i, 0, [b;l;s;sa], names');];
            % SVM's multiclass one-to-all
            p3 = [p3 kfoldCrossValidation(i, 1, data, names')];
            % SVM's multiclass one-to-one
            
            svm1to1 = kfoldCrossValidation(i, 2, data, names', kernel, -3);
            % try with differents gamma in the rbf kernel
            if(kernel == 4)
                maxx = svm1to1;
                maxind = -3;
                for h = -2:1:4
                    svm1to1 = kfoldCrossValidation(i, 2, data, names', kernel, h);
                    if(svm1to1 > maxx) maxx = svm1to1; maxind = h; end
                end
                svm1to1 = maxx;
            end
            
            p4 = [p4 svm1to1];
            plot(p1,p2,'-',p1,p3,'-',p1,p4,'-');      %  Plot Random Forest and SVM
            %plot(p1,p3,'-',p1,p4,'-');      %  Plot Random Forest and SVM

            xlabel('k');       %  add axis labels and plot title
            ylabel('efectiveness ');
            title('KFold Cross Validation');
            legend('Random Forest','Classify','SVM 1to1');
            %legend('Random Forest','SVM 1to1');
        end
    end
    v = [rf, svm, svm1to1];
    %rf = 1;
    %svm = 1;
    %svm1to1 = 1;
    %plot(p1, [p2; p3]);
end