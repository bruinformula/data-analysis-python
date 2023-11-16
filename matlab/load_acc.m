function [timestamps, acc_x, acc_y, acc_z, acc_m] = load_acc(table)

    % Filter table for lines that start with ACC
    acc_idx = categorical(table.Var1) == 'ACC';
    
    % Load arrays from table
    timestamps  = table.Var2(acc_idx);
    acc_x       = table.Var3(acc_idx);
    acc_y       = table.Var4(acc_idx);
    acc_z       = table.Var5(acc_idx);
    
    % Convert from string to double if necessary
    if ~isa(timestamps, 'double')
        timestamps = str2double(timestamps);
    end
    if ~isa(acc_x, 'double')
        acc_x = str2double(acc_x);
    end
    if ~isa(acc_y, 'double')
        acc_y = str2double(acc_y);
    end
    if ~isa(acc_z, 'double')
        acc_z = str2double(acc_z);
    end

    % Account for gravity by using first hundred vals as calibration
    acc_x = acc_x - mean(acc_x(1:100));
    acc_y = acc_y - mean(acc_y(1:100));
    acc_z = acc_z - mean(acc_z(1:100));

    % Convert from microseconds/microgs to seconds/gs
    timestamps = timestamps / 1e6;
    acc_x = acc_x / 1e6;
    acc_y = acc_y / 1e6;
    acc_z = acc_z / 1e6;
    
    % Get the magnitude by pythagorean theorem
    acc_m = sqrt(acc_x.^2 + acc_y.^2 + acc_z.^2);

end