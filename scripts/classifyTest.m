% elemental classifier
function [c,r] = classifyTest(train,names,test,gtruth)
    c = classify(test,train,names,'quadratic');
    
    r = sum(strcmp(c,gtruth));
end