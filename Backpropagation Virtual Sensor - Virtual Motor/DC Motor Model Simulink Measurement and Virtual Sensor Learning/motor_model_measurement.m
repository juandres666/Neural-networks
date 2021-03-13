open_system('dc_motor_model');
%get_param('dc_motor_model/Friction','DialogParameters');

h=waitbar(0,'1','Name','DC Motor Measurement...','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');setappdata(h,'canceling',0)

i=0;
for trq_motor=0.0001:0.2/60:0.2
    set_param('dc_motor_model/Friction','brkwy_trq',num2str(trq_motor,'%0.9f'));
    set_param('dc_motor_model/Friction','Col_trq' , num2str(trq_motor,'%0.9f'));
    set_param(gcs,'SimulationCommand','Start');
    
    i=i+1;
    pause(1);
    if getappdata(h,'canceling'),break,end;waitbar(i/60,h,sprintf('%d',i));
    
    v_dc_motor_p(i)  =  v_motor;
    i_dc_motor_p(i)  =  i_motor;
    rpm_dc_motor_p(i)=rpm_motor;
    trq_dc_motor_p(i)=trq_motor;
end

set_param('dc_motor_model/Friction','brkwy_trq','3.0e-2');
set_param('dc_motor_model/Friction','Col_trq' , '3.0e-2');
save_system('dc_motor_model');
close_system('dc_motor_model');

if ~getappdata(h,'canceling')
    save('prueba','-regexp','v_dc_motor_p','i_dc_motor_p','rpm_dc_motor_p','trq_dc_motor_p');
end
delete(h);
clear all;