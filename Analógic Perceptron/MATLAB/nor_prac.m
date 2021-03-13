clc, close all;
red=newp([0 5;0 5],1)
p = [0 0 5 5;0 5 0 5]
t=[1 0 0 0]
a=sim(red,p)
red=train(red,p,t);
peso=red.iw{1}
bias=red.b{1}
sim(red,p)
hold on;
figure,plotpv(p,t);
plotpc(red.IW{1},red.b{1});
grid on
hold off;