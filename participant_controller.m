% Initialize the robot
timestep = wb_robot_get_basic_time_step();

% Obtain waypoints
waypoints_string = wb_robot_get_custom_data();
waypoints_flat = str2num(waypoints_string);
waypoints_transposed = reshape(waypoints_flat,[2,10]);
waypoints = transpose(waypoints_transposed);
wb_console_print(sprintf('Waypoints: \n'), WB_STDOUT);
for i = 1:10
  wb_console_print(sprintf('[%f %f] ', waypoints(i,1), waypoints(i,2)), WB_STDOUT);
end
wb_console_print(sprintf('\n'), WB_STDOUT);

% Initialize devices
motor_left = wb_robot_get_device('wheel_left_joint');
motor_right = wb_robot_get_device('wheel_right_joint');
gps = wb_robot_get_device('gps');

wb_motor_set_velocity(motor_left, 0.0);
wb_motor_set_velocity(motor_right, 0.0);

wb_motor_set_position(motor_left, inf);
wb_motor_set_position(motor_right, inf);

wb_gps_enable(gps, timestep);

% Main loop:
% - perform simulation steps until Webots is stopping the controller
while wb_robot_step(timestep) ~= -1
  pos = wb_gps_get_values(gps);
  wb_console_print(sprintf('Hello World from MATLAB! [%f %f %f]\n', pos(1), pos(2), pos(3)), WB_STDOUT);
  wb_motor_set_velocity(motor_left, 5.0);
  wb_motor_set_velocity(motor_right, 5.0);
end
