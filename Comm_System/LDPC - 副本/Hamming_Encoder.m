function code = Hamming_Encoder(msg)
    % 汉明码生成矩阵G
    G = [1 0 0 0 1 1 1
        0 1 0 0 1 1 0
        0 0 1 0 1 0 1
        0 0 0 1 0 1 1];
    code = bitand(msg * G, 1);
end
