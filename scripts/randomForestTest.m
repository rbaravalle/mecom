% Classifies the test set using Random Forests
function [classes,r] = randomForestTest(train,names,test,gtruth)
 
    b = TreeBagger(50,train,names,'oobpred','on'); % random forest    
    classes = b.predict(test);
    
    r = sum(strcmp(classes,gtruth));
    
end