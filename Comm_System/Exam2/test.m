H = [1 1 1 0 1 0 0
    1 1 0 1 0 1 0
    1 0 1 1 0 0 1];
G = [1 0 0 0 1 1 1
     0 1 0 0 1 1 0
     0 0 1 0 1 0 1
     0 0 0 1 0 1 1];
A = [0 0 0 0 0 0 0
     0 0 0 1 0 1 1
     0 0 1 0 1 0 1
     0 0 1 1 1 1 0
     0 1 0 0 1 1 0
     0 1 1 0 0 1 1
     0 1 1 1 0 0 0
     1 0 0 0 1 1 1
     1 0 0 1 1 0 0
     1 0 1 0 0 1 0
     1 0 1 1 0 0 1
     1 1 0 0 0 0 1
     1 1 0 1 0 1 0
     1 1 1 0 1 0 0
     1 1 1 1 0 0 1
];
B = [0 0 0 0
     0 0 0 1
     0 0 1 0
     0 0 1 1
     0 1 0 0
     0 1 0 1
     0 1 1 0
     0 1 1 1
     1 0 0 0
     1 0 0 1
     1 0 1 0
     1 0 1 1
     1 1 0 0
     1 1 0 1
     1 1 1 0
     1 1 1 1
    ];
S = bitand(H * A', 1)';
display(S);
% display(bi2de(bitand(H * bitand((B * G), 1)', 1)', 'left-msb'));