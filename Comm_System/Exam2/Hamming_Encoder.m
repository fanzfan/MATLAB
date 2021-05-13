function code = Hamming_Encoder(G, msg)
    code = bitand(msg * G, 1);
end
