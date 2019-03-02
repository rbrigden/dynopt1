import torch
import torch.nn as nn
import numpy as np
from plot import plot_snake
import torch.optim

import matplotlib as mpl
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib.pyplot as plt


class ForwardKinematics(nn.Module):

    def __init__(self, num_links):
        super(ForwardKinematics, self).__init__()
        theta = torch.zeros((num_links, 3))
        self.theta = nn.Parameter(theta)

    def forward(self, link_lengths):
        translations = [torch.tensor([0., 0., 1.]).view(3, 1) * l for l in link_lengths]
        effector_positions = []
        rots = [euler_to_rot(self.theta[i]) for i in range(self.theta.size(0))]

        # for each link position
        for i in range(len(link_lengths)):
            eff_pos = torch.zeros((3, 1))
            for j in range(i, -1, -1):
                eff_pos = torch.matmul(rots[j], eff_pos + translations[j])
            effector_positions.append(eff_pos)
        return torch.stack(effector_positions).squeeze(2)


# Calculates Rotation Matrix given euler angles.
def euler_to_rot(theta):
    rot_x = torch.tensor([[1, 0, 0],
                          [0, 0, 0],
                          [0, 0, 0]
                          ]).float()

    rot_x[1, 1] += torch.cos(theta[0])
    rot_x[1, 2] += -torch.sin(theta[0])
    rot_x[2, 1] += torch.sin(theta[0])
    rot_x[2, 2] += torch.cos(theta[0])

    rot_y = torch.tensor([[0, 0, 0],
                          [0, 1, 0],
                          [0, 0, 0]
                          ]).float()

    rot_y[0, 0] += torch.cos(theta[1])
    rot_y[0, 2] += torch.sin(theta[1])
    rot_y[2, 0] += -torch.sin(theta[1])
    rot_y[2, 2] += torch.cos(theta[1])

    rot_z = torch.tensor([[0, 0, 0],
                          [0, 0, 0],
                          [0, 0, 1]
                          ]).float()

    rot_z[0, 0] += torch.cos(theta[2])
    rot_z[0, 1] += -torch.sin(theta[2])
    rot_z[1, 0] += torch.sin(theta[2])
    rot_z[1, 1] += torch.cos(theta[2])

    rot = torch.matmul(rot_z, torch.matmul(rot_y, rot_x))

    return rot


def forward_kinematics(link_lengths, joint_angles):
    """

    :param link_lengths: list of link lengths
    :param joint_angles: ndarray of n euler angles (n, 3)
    :return: end effector position and quaternion
    """

    translations = [torch.tensor([0., 0., 1.]).view(3, 1) * l for l in link_lengths]
    rots = [euler_to_rot(joint_angles[i]) for i in range(joint_angles.size(0))]

    effector_positions = []

    # for each link position
    for i in range(len(link_lengths)):
        eff_pos = torch.zeros((3, 1))
        for j in range(i, -1, -1):
            eff_pos = torch.matmul(rots[j], eff_pos + translations[j])
        effector_positions.append(eff_pos)
    return torch.stack(effector_positions).squeeze(2)


def main():
    num_links = 4
    link_lengths = np.ones(num_links, ) * num_links
    joint_angles = np.array(
        [
            [0, 0, 0],
            [np.pi / 6, 0, np.pi / 4],
            [0, 0, np.pi / 9],
            [np.pi / 7, np.pi / 3, np.pi / 9]
        ]
    )

    link_lengths, joint_angles = torch.FloatTensor(link_lengths), torch.FloatTensor(joint_angles)

    fk = ForwardKinematics(num_links)
    optimizer = torch.optim.SGD(params=fk.parameters(), lr=1e-2)
    fig = plt.figure()
    ax = fig.gca(projection='3d')
    l = None
    for i in range(1000):
        optimizer.zero_grad()
        positions = fk(link_lengths)
        target = torch.tensor([2., 3., 6.])
        loss_fn = nn.MSELoss()
        loss = loss_fn(positions[-1], target)
        loss.backward()

        print(fk.theta.grad.data)
        optimizer.step()
        effector_positions = positions.data.numpy()

        n, _ = effector_positions.shape
        positions = np.zeros((n + 1, 3))
        positions[1:] = effector_positions
        l = ax.plot(positions[:, 0], positions[:, 1], zs=positions[:, 2], marker='o', c='b')
        plt.draw()
        plt.pause(.01)
        l.pop(0).remove()

        # print(effector_positions[-1])


if __name__ == '__main__':
    main()
