% returns the mean of running the classifiers N times

function res = compProm(b,l,s,sa,N)
    a = zeros(3,N);
    for i = 1:N
        a(:,i) = comparar(b,l,s,sa);
    end
    
    % graph
    res = [ mean(a(1:1,:)),  mean(a(2:2,:)), mean(a(3:3,:))];
end