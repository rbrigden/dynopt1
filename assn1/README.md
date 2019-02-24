# Dynamic Optimization Homework 1
In this project we ([Ryan Brigden](https://github.com/rbrigden), [Shaurya Khazanchi](https://github.com/seyserkoze) and [Marcus Greer](https://github.com/marcusgreer)) used function optimization to perform [inverse kinematics](https://en.wikipedia.org/wiki/Inverse_kinematics) and model a snake robot. We were tasked with controlling the position of this robot, allowing it to reach into a cluttered environment and grasp an target object. The base of the robot that we are modeling is bolted to the coordinate frame origin pointing along the global X axis, with the second axis aligned with the global Y (horizontal) axis and the third axis aligned with the global Z (vertical) axis. 

## Part 1
We first wrote a program that performed forward kinematics. Given a set of euler angles (used to encode the robot's joints' roll, pitch and yaw values) this program positions the tip of the arm at a targeted location and orientation. Functionally we iterate through the joints, and each joint is translated along the X-axis by the length of the previous link and then rotated with respect to the frame of the previous joint. This process rotates all of the downstream links so ultimately all the links and joints are rotated correctly with respect to the origin. We were able to use this program to easily manipulate.

We then used this forward kinematics program in conjunction with soft constrints, and hard constraints to conduct a multivariable optimization experiment. Our soft constrints came from cost functions that took into account the orientation of the final link compared to the goal and the proximity of each joint to the obsticles to conduct, and our hard constraints came from the specification of the 

Using these cost funcitons and forward kinematics programs in matlab's function [fmincon](https://www.mathworks.com/help/optim/ug/fmincon.html) function we were able to perform a constrined optimization, and find an optimal positioning for the robotic snake arm.

## Part 2
Once we had created the simulation for this robotic arm's traversal of the space while it avoids obstacles a systematic way to compute the derivative of the tip position and orientation with respect to each set of joint angles. 

We used the the matlab function [xyz] to perform an analytical derivative on the cost function that we had developed in the previous part. 

Once we did this we found that providing a derivative to the optimization program from part 1, both our performance and solutions improved significantly.

## Part 3


## Part 4
Finally we were tasked with finding multiple distinct local minima, and providing the user with a choice of local minima. We did so by probing different starting points and seeing what local minima those different starting points gave us.
