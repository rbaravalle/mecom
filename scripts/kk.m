%Metodo de diferencias progresivas
%La matriz W contiene los resultados del metodo. Las columnas corresponden
%a la variacion en el tiempo, y las filas a la variacion en x.
clear
close all
clc
%Entrada de datos
Preguntas={'Longitud de la barra' 
'Limite de Tiempo'
'Numero de particiones en el tiempo'
'Numero de particiones en x'
'Coeficiente alfa'
'Funcion de temperatura inicial'};
Titulo = 'Entrada de Datos (Metodo de diferencias progresivas)';
Defecto = {'1', '0.40' , '40' , '10' , '1' , 'sin(pi*x)'};
datos=inputdlg(Preguntas, Titulo, 1, Defecto);
L=str2num(datos{1});
T=str2num(datos{2});
N=str2num(datos{3});
m=str2num(datos{4});
alfa=str2num(datos{5});
f=datos{6};
%Incializacion
h=L/m;
k=T/N;
lambda=alfa^2*k/h^2;
v(m,1)=0;
w(m,1)=0;
W=[];
x=sym('x');
%Obtencion de la solucion
%Obtencion de los resultados
for(i=1:m-1)
x=i*h;
v(i,1)=eval(f);
end
W=[W;'v'];
for j=1:N
t=j*k;
w(1,1)=((1-2*lambda)*v(1,1)+lambda*v(2,1));
for i=2:m-1
w(i,1)=(1-2*lambda)*v(i,1)+lambda*(v(i+1,1)+v(i-1,1));

end
v=w;
W=[W;'v'];
end
%Graficacion de los resultados
num_rows=size(W,1);
zeros_col=zeros(num_rows,1);
W=[zeros_col W];
plot(W(1,2));
limites=axis;
maximo=limites(4);
for(a=2:size(W,1))
plot(W(a,:))
limites=[1 m+1 0 maximo];
axis(limites);
pause(0.01)
end
title('Temperatura vs. x')
ylabel('u(x)')
xlabel('x')
figure
surf(W)
title('Superficie de Distribucion de Temperatura')
ylabel('t')
xlabel('x')
zlabel('u(x,t)')
shading interp
