load motor_model_measurement;

p=vertcat(i_dc_motor,v_dc_motor);
t=rpm_dc_motor;

%net=newff([14 24; 0 3.5],[3,1],{'tansig','purelin'},'trainlm');
net=newff(p,t,[3,2,1],{'tansig','tansig','purelin'},'trainlm');

net=init(net);

net.trainParam.show = 500;
net.trainParam.lr = 0.05;
net.trainParam.epochs = 2000;
net.trainParam.goal = 1e-5;

net=train(net,p,t);

save('motor_virtual_sensor_soso','-regexp','net');