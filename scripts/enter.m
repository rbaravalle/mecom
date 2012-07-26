function err = enter(k,method,baguette,lactal,salvado,sandwich,names)

    err = kfoldCrossValidation(k, method, [baguette;lactal;salvado;sandwich], names');
end