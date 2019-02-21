function [dist] = quatDistance(q0,q1)
%QUATDISTANCE find distance between two quaternions.Outputs between 0-1
    dist = abs(1 - dot(q0, q1)^2);
end



