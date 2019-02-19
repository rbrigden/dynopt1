function [cost] = obstacleCost(linkPoints,obstacles)
% obstacleCost:
% given a matrix of obstables where each obstacle is a row of x y z radius (spheres)
% get the distance to all link points (returned by the fk function)

%TODO: make distance from middle of links instead of endpoints
N = size(linkPoints,1);
M = size(obstacles,1);

obstaclePos = obstacles(:, 1:end-1);
obstacleRad = obstacles(:, end);

cost = 0;
for n = 1:N
    for m = 1:M
        dist = sqrt(sum((linkPoints(n,:) - obstaclePos(m, :)).^2));
        cost = cost + dist - obstacleRad(m);
    end
end

end

