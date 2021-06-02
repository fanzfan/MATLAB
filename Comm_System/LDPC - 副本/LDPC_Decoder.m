%% 适用于 BPSK 的 LDPC 译码算法，采用最小和算法
% 适用于符合CCSDS标准的 LDPC码
% H：校验矩阵，receiveSignal：接收到的bpsk信号，未量化
% MAX_ITER_NUM：最大迭代次数

%% 函数主部分
function [iter, decoderData] = LDPC_Decoder(H, receiveSignal, MAX_ITER_NUM)

% 参数初始化
gama = 0.93;
[r_mark, ~] = find(H ~= 0);
HColNum = sum(H);
HRowNum = {1, size(H, 1)};
for rowH = 1:size(H, 1)
    HRowNum{rowH} = find(r_mark == rowH);
end
[~,N] = size(H);
vl = receiveSignal;
decoderData = zeros(1,N);
uml = zeros(1,sum(HColNum));
vml = uml;
ColStart = 1;
for i=1:length(HColNum)
    vml(ColStart:ColStart+HColNum(i)-1) = vl(i);
    ColStart = ColStart+HColNum(i);
end

for iter=1:MAX_ITER_NUM
    % 校验节点操作
    for i=1:length(HRowNum)
        L_col = HRowNum{i};
        vmltemp = vml(L_col);
        vmlMark = ones(size(vmltemp));
        vmlMark(vmltemp<0) = -1;
        vmlMark = prod(vmlMark);
        minvml = sort(abs(vmltemp));
        for L_col_i = 1:length(L_col)
            if minvml(1)==abs(vmltemp(L_col_i))
                if vmltemp(L_col_i)<0
                    vmltemp(L_col_i) = -vmlMark*minvml(2);
                else
                    vmltemp(L_col_i) = vmlMark*minvml(2);
                end
            else
                if vmltemp(L_col_i)<0
                    vmltemp(L_col_i) = -vmlMark*minvml(1);
                else
                    vmltemp(L_col_i) = vmlMark*minvml(1);
                end
            end
        end
        uml(L_col) = gama*vmltemp;
    end
    % 变量节点操作
    ColStart = 1;
    qn0_1 = ones(1,N);
    for i=1:length(HColNum)
        umltemp = uml(ColStart:ColStart+HColNum(i)-1);
        temp = sum(umltemp);
        qn0_1(i) = temp + vl(i);
        umltemp = temp - umltemp;
        vml(ColStart:ColStart+HColNum(i)-1) = umltemp + vl(i);
        
        ColStart = ColStart+HColNum(i);
    end
    % 译码判决
    decoderData(qn0_1>=0) = 0;
    decoderData(qn0_1<0) = 1;
    % 校验通过（无错），返回即可
    if(bitand(H*decoderData',1)==0)
        break;
    end
end


