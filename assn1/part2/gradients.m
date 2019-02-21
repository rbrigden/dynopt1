syms rotation(alpha, beta, gamma)

num_links = 4;
link_lengths = [2 2 2 2];
angles = sym('a%d%d', [num_links 3]);

rx = [1 0 0; 0, cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];
ry = [cos(beta) 0 sin(beta) ; 0 1 0; -sin(beta) 0 cos(beta)];
rz = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];
rotation(alpha, beta, gamma) = rz * (ry * rx);

eff_pos = sym('origin', [3 1]);
for i = num_links : -1 : 1
    R = rotation(angles(i, 1), angles(i, 2), angles(i, 3));
    eff_pos = R * (eff_pos + [link_lengths(i) 0 0].');
end

target = [1 2 7].';

obj = (target - eff_pos).' * (target - eff_pos);
grad = gradient(obj, angles(4).');
grad = subs(grad, angles, zeros(4, 3));
disp(grad)

