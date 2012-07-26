% implements KFold Cross Validation using the method 'method'
function cvErr = kfoldCrossValidation(k,method,data,names, kernel, gamma)
    e = 0;
    M = size(data);
    M = M(1);
    %if(mod(k,M) ~= 0)
    %    error('size(data) must be multiple of k');
    %end
    
    CVO = cvpartition(names,'kfold',k);
    
    err = zeros(CVO.NumTestSets,1);
    
    for i = 1:CVO.NumTestSets
      trIdx = CVO.training(i); % trIdx = vector with 1 in indexes of the training set
      teIdx = CVO.test(i); % teIdx = vector with 1 in indexes of the test set 
      % random Forests or SVM's
      
      
      %scaling
      vtrain = data(trIdx,:);
      vtest = data(teIdx,:);
      autosc = 'true';
      if(strcmp(autosc,'true') == 0)
        cantCarac = size(vtrain,2);

        % normalize
        for t = 1:size(vtrain,1);
            %vtrain(t,:) = vtrain(t,:)/norm(vtrain(t,:));
        end
        for t = 1:size(vtest,1);
            %vtest(t,:) = vtest(t,:)/norm(vtest(t,:));
        end
        
        maxx = zeros(1,cantCarac,1);
        minn = zeros(1,cantCarac,1);
        for t = 1:cantCarac
            maxx(t) = -10000;
            minn(t) = 10000;
        end
        N = size(vtrain,1);
        for s = 1:N
            for t = 1:cantCarac
                if(maxx(t) < vtrain(s,t)) maxx(t) = vtrain(s,t); end
                if(minn(t) > vtrain(s,t)) minn(t) = vtrain(s,t); end
            end
        end

        % scaling
        for s = 1:N     
            for t = 1:cantCarac
                vtrain(s,t) = (vtrain(s,t)-minn(t))/(maxx(t)-minn(t));
            end
        end
        
        for s = 1:size(vtest,1)     
            for t = 1:cantCarac
                vtest(s,t) = (vtest(s,t)-minn(t))/(maxx(t)-minn(t));
            end
        end
      end
      
      if(method == 0)
        [ytest,r] = randomForestTest(vtrain,names(trIdx,:), vtest,names(teIdx,:));
      end
      if(method == 1)
        %[ytest,r] = svmTest(vtrain,names(trIdx,:),vtest,names(teIdx,:));
        [ytest,r] = classifyTest(vtrain,names(trIdx,:),vtest,names(teIdx,:));
      end
      if(method == 2)
        [ytest,r] = svmTestOneToOne(vtrain,names(trIdx,:),vtest,names(teIdx,:),kernel,power(2,gamma), autosc);
      end
      
      err(i) = r;%sum(~strcmp(ytest,names(teIdx)));
    end
    cvErr = sum(err)/sum(CVO.TestSize);
    
end