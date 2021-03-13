%% Image Data,
image='ln.bmp';%8x7
i=0;
for n=0:9
    image(1)=char(n+48);    
    for l=1:8
        image(2)=char(96+l);%abcdefgh
        i=i+1;
        p(:,i)=double(reshape(imread(image),56,1));
        t(1,i)=double(n);
    end
end
clear image i n l
%% Backpropagation Learning
net=newff(minmax(p),[8,64,1],{'tansig','tansig','purelin'},'trainlm');

net.trainParam.show = 500;
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-99;
net.trainParam.min_grad = 1e-99;
net.trainParam.lr = 0.05;

net=train(net,p,t);
%save('NumbersRecogitionFine','-regexp','net');