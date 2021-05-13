function decodeMsg = Hamming_Decoder(H, recCode)
    % 校验子 S
    S = bitand(H * recCode', 1)';
    S = bi2de(S, 'left-msb');
    % 校验过程
    for j = 1:length(S)
        if (S(j) > 0)
            recCode(j, 8 - S(j)) = -recCode(j, 8 - S(j)) + 1;
        end
    end
    % 最终得到的数据
    decodeMsg = recCode(:, 1:4);
end
