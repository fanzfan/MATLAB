function decodeMsg = Hamming_Decoder(H, recCode)
    % 校验子 S
    S = bitand(H * recCode', 1)';
    S = bi2de(S, 'left-msb');
    % 校验过程
    for j = 1:length(S)
        if (S(j) > 0)
            temp = recCode(j, :);
            temp(8 - S(j)) = -temp(8 - S(j)) + 1;
            if(bitand(H * temp', 1)==0)
                recCode(j, :) = temp;
            end
        end
    end
    % 最终得到的数据
    decodeMsg = recCode(:, 1:4);
end
