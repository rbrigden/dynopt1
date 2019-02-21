function [cost] = obstacleCost(linkPoints,obstacles)
% obstacleCost:
% given a matrix of obstables where each obstacle is a row of x y z radius (spheres)
% get the distance to all link points (returned by the fk function)

%TODO: make distance from middle of links instead of endpoints
link_t = linkPoints.';
obs_t = obstacles.';
N = size(link_t,1);
M = size(obs_t,1);

obstaclePos = obs_t(:, 1:end-1);
obstacleRad = obs_t(:, end);

cost = 0;
for n = 1:N
    for m = 1:M
        dist = sqrt(sum((link_t(n,:) - obstaclePos(m, :)).^2));
        cost = cost + dist - obstacleRad(m);
    end
end

cost = -cost;

end

