%% LDPC码编码程序
% 使用线性分组码基本性质即可完成
function [LDPC_code] = LDPC_Encoder(G,msg)
    LDPC_code = bitand(msg * G, 1);
end

