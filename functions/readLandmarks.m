function [landmark] = readLandmarks()
% read data
    [id x y x_std y_std] = textread('ds1_Landmark_Groundtruth.dat', '%f %f %f %f %f','commentstyle','shell');
    landmark= [id x y x_std y_std];
end