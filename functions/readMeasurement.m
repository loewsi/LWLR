function [time, barcode_num, r, b] = readMeasurement()

    [time, barcode_num, r b] = textread('ds0_Measurement.dat', '%f %f %f %f','commentstyle','shell');
    
end