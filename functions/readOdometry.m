function [t, v, w] = readOdometry()
% read data
    [t, v, w] = textread('ds1_Odometry.dat', '%f %f %f','commentstyle','shell');
    

end