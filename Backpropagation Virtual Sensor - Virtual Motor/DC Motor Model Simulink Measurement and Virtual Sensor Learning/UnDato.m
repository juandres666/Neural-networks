load motor_virtual_sensor_soso

open_system('dc_motor_model');

trq=input('Torque = ')%0.0001 - 0.2

set_param('dc_motor_model/Friction','brkwy_trq',num2str(trq,'%0.6f'));
set_param('dc_motor_model/Friction','Col_trq' , num2str(trq,'%0.6f'));
set_param(gcs,'SimulationCommand','Start');
pause(1)

rpm_motor

rpm_virtual_sensor=sim(net,[i_motor;v_motor])