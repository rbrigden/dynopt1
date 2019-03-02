syms rotation(alpha, beta, gamma)
syms a1 a2 a3

% Compute J_p(theta)

rx = [1 0 0; 0, cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];
ry = [cos(beta) 0 sin(beta) ; 0 1 0; -sin(beta) 0 cos(beta)];
rz = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];
rotation(alpha, beta, gamma) = rz * (ry * rx);

angles = [a1 a2 a3].'

R = rotation(angles(1), angles(2), angles(3));
p0 = sym('p', [3, 1])

l1 = sym('l', [3, 1])
p1 = R * (p0 + l1)


dp_dtheta = jacobian(p1, angles);

