function [LDPC_code] = LDPC_Encoder(G,msg)
    LDPC_code = bitand(msg * G, 1);
end

