% Cancelaci?n de ruido usando una neurona artificial (ADALINE) y la regla de Widrow-Hoff.

% Se?al nula, ruido de audio 1k, 64 muestras, lr=1e-4, paso fijo

 

clear all;

close all;

home;

 

% Cargar y procesar datos -- Normalizar

 

% leo la se?al muestreada a 22kHz

XXX = wavread('telefono.wav')';

% submuestreo a 11kHz

XX=0.4*decimate(XXX,2);

 

% leo el ruido muestreada a 11kHz

PP = 0.4*wavread('fandango.wav')';

 

l=min(length(PP),length(XX));

X=XX(1:l);

P=PP(1:l);

 

clear XX XXX PP;

 

% defino la frecuencia de muestreo y el paso de tiempo

frec=11000;

t = (0:l-1)/frec;

 

% paso el ruido por un filtro para distorsionarlo m?s.

%N=filter([zeros(1,10) rand(1,20)/10],1,P);

 

% sumo el ruido a la se?al

%T = X + N;

T=X+P;%se?al + ruido

 

entradas=P;%ruido

salidas=T;%=X+P se?al + ruido

 

% Neurona

no_entradas=3;

 

% pesos iniciales

w=0.001*ones(1,no_entradas);

 

% Learning Rate

% lr=0.03; con 64

%lr=0.01; con 3

lr=0.01;

 

e=zeros(1,l);

 

for i=no_entradas:l,

   e(i)=salidas(i)-w*entradas(i-no_entradas+1:i)';

   grad=2*e(i)*entradas(i-no_entradas+1:i);

   w=w+grad*lr;

   %lr=lr+lr/length(entradas);

end

 

ejes=[0 t(end) -0.5 0.5];

 

subplot(3,1,1)

plot(t,X)

title('Se?al')

axis(ejes)

subplot(3,1,2)

plot(t,P)

title('Ruido')

axis(ejes)

subplot(3,1,3)

plot(t,T)

title('Se?al contaminada con ruido')

axis(ejes)

 

ejes=[0 t(end) -0.5 0.5];

 

figure

subplot(3,1,1)

plot(t,X)

title('Se?al original')

axis(ejes)

subplot(3,1,2)

plot(t,e)

title('Se?al recuperada')

axis(ejes)

subplot(3,1,3)

plot(t,X-e)

title(['Diferencia entre la se?al original y la se?al recuperada (lr= '  num2str(lr) ')'])

axis(ejes)