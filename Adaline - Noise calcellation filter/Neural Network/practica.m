net=newp([0 5;0 5],1)
p=[0 0 5 5;0 5 0 5]
t=[0 1 1 1]
net = init(net);
net.b{1} = 0;
y = sim(net,p)
net = train(net,p,t);
y = sim(net,p)
peso=net.iw{1}
bias=net.b{1}
plotpv(p,t)
plotpc(net.iw{1,1},net.b{1})
grid on