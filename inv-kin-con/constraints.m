%%% constraints for optimizing 3 joint inverse kinematics
function [ineq_violations,eq_violations]=constraints(p)

global x_d

pos = fk( p );

% be at the target
eq_violations(1) = pos(1) - x_d(1);
eq_violations(2) = pos(2) - x_d(2);

ineq_violations=[];

end
%% final end


