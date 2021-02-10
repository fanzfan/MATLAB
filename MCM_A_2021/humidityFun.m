%%% Interpolate the humidity with given data

function [humidity] = humidityFun(arg, ts)
    data = arg * ones(12);

    switch (arg)
        case 1
            data = [31	59	56	58	46	32	21 28	20	22	36	37];
        case 2
            data = [21	28	45	30	26	30	32 29	23	20	16	21];
        case 3
            data = [92	93	95	96	95	93	91 91	89	91	90	92];
        case 4
            data = [80.2 78.2 76.8 79 75.4 81.7 81.1 77.9 76 75.2 76.4 79.1];
        case 5
            data = [43 67 72 61	44 41 59 58 52 37 28 30];
    end

    tspan = 1:30.41:760;
    humidity = interp1(tspan, [data data data(1)], ts, 'spline');
    humidity = humidity(1:length(ts));
end
