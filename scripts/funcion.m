function res = funcion(m,h)
    function y = f(x)
        y = m*x+h;
    end

    %fplot(@f,[0 10]);
    res = @f;
end