function code = LDPC_Encoder(n, k, msg, G)
%LDPC_Encoder n, k, msg, Gcription
%
% Syntax: code = LDPC_Encoder(n, k, msg, G)
%
% Long description
    [K, N] = size(G);
    if K~=k || N~= n
        error('Encoder parameter is error');
    end
    msg = gf(msg, 2);
    parity = msg * G;
    code = [msg.x parity.x];
end