function [t, x, y, theta] = readGroundtruth()
    [t x y theta] = textread('ds1_Groundtruth.dat', '%f %f %f %f','commentstyle','shell');
end
