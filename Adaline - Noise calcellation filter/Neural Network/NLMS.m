% Cancelación de ruido usando una neurona artificial (ADALINE) y la regla de Widrow-Hoff.

% uso el algortimo NLMS

 

 

senial='telefono.wav';

% leo la señal a 22kHz y la submuestreo a 11kHz

XX = 0.4*decimate(wavread(senial),2)';

 

ruido='fandango.wav';

% leo el ruido

PP =0.4*wavread(ruido)';

 

% fs=11 kHz

% asumo que los sonidos son mono

l=min(length(PP),length(XX));

 

X=XX(1:l);

P=PP(1:l);

clear XX,PP;

 

% frecuencia de muestreo

frec=3500;

t = (0:l-1)/frec;

 

% sumo el ruido a la señal

T = X + P;

%T = X + filter([0.5 0.4],1,P);

 

entradas=P;

salidas=T;

 

% Neurona

no_entradas=64;

 

w=0.001*ones(1,no_entradas);

%b=rand(no_entradas);

 

%lr=0.01;         % Learning Rate

%k1=5e-3; % con 64 muestras

%k1=1e-3; % con 3 muestras

k1=5e-3;

k2=0.01;          % defino el lr máximo como 0.5

 

e=zeros(1,l);

 

lrv=zeros(1,l);

for i=no_entradas:l,

   ent_act=entradas(i-no_entradas+1:i);

   lr=k1./(ent_act*ent_act'+k2);

   lrv(i)=lr;

   %if i>=l/10,

   %k1=5e-5;  

   %end

   e(i)=salidas(i)-w*ent_act';

   grad=2*e(i)*ent_act;

   w=w+grad*lr;

end

 

ejes=[0 t(end) -0.5 0.5];

 

subplot(3,1,1)

plot(t,X)

title('Señal')

axis(ejes)

subplot(3,1,2)

plot(t,P)

title('Ruido')

axis(ejes)

subplot(3,1,3)

plot(t,T)

title('Señal contaminada con ruido')

axis(ejes+[0 0 -0.3 0.3])

 

ejes=[0 t(end) -0.5 0.5];

 

figure

subplot(3,1,1)

plot(t,X)

title('Señal original')

axis(ejes)

subplot(3,1,2)

plot(t,e)

title('Señal recuperada')

axis(ejes)

subplot(3,1,3)

plot(t,X-e)

title(['Diferencia entre la señal original y la señal recuperada (lr= '  num2str(lr) ')'])

axis(ejes)

figure

plot(t,lrv)

%soundsc(e,frec)

%salida=input('Ingrese el nombre del archivo de salida: ');

%salida='./sonido3/telefono_rec.wav';

%wavwrite(e,frec,8,salida);