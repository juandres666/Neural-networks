clear all;
close all;
clc;
freq=6000
%senal normal 
[se,fs]=wavread('prueb1.wav');
se=se';
soundsc(se,fs);
%aux1=aux(:,1);
tam1=size(se)-1;
figure,plot(se);
grid on;
title('Se�al de Audio');

%Para generar un ruido
t=(0:tam1(1,2))/fs;
w=randn(1,tam1(1,2)+1);
figure,plot(w);
grid on;
title('Se�al Interferente');
grid on;
soundsc(w,fs);

%sumo las senales de ruido y la original
r=se+w;
R=size(r)
figure,
figure,plot(r);
title('Voz + Interferencia');
grid on;
soundsc(r,fs);

%realizacion del filtro
r=se+w;
P=con2seq(w);                                          %Hacemos en filas, no en columnas
T=con2seq(r);                   
net=newlin([-2,2],1,[0,1],0.2);                        %Definimos valores max, min y 1 neurona                                                       %Error m�nimo: 0.2
wts=net.IW{1,1};
bias=net.b{1};
net.adaptParam.epoch=20;
[net,Y,E,Pf]=adapt(net,P,T);
Y=cell2mat(Y);
tam=size(t);
for i=1:tam(1,2)
    e(:,i)=r(:,i)-Y(:,i);
end
soundsc(e,fs);
figure,plot(e,'c');
title('Se�al Filtrada'); 
grid on;