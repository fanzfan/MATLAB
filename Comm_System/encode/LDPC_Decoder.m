function [dec, success] = LDPC_Decoder(receiveWord, sigma, H, IterNum)
    [M, N] = size(H);
    K = N - M;
    rate = K / N;
    H = int8(H);

    maxRowDegree = max(sum(transpose(H)));
    maxColumnDegree = max(sum(H));

    VNLen = zeros(1, N);
    VNSet = zeros(N, maxColumnDegree);

    CNLen = zeros(1, M);
    CNSet = zeros(M, maxRowDegree);

    for i = 1:N
        temp = find(H(:, i));
        VNLen(i) = length(temp);

        for j = 1:VNLen(i)
            VNSet(i, j) = temp(j);
        end

    end

    for i = 1:M
        temp = find(H(:, i));
        CNLen(i) = length(temp);

        for j = 1:CNLen(i)
            CNSet(i, j) = temp(j);
        end

    end

    success = 0;
    p0 = (1 + exp(-2 * (sigma^(-2)) .* receiveWord)).^(-1);
    p1 = (1 + exp(2 * (sigma^(-2)) .* receiveWord)).^(-1);
    messQ0 = zeros(M, N); messQ1 = zeros(M, N);
    messR0 = zeros(M, N); messR1 = zeros(M, N);

    for i = 1:N

        for j = 1:VNLen(i)
            messQ0(VNSet(i, j), i) = p0(i);
            messQ1(VNSet(i, j), i) = p1(i);
        end

    end

    iter = 0;

    for i = 1:IterNum
        iter = iter + 1;

        for j = 1:M

            for k = 1:CNLen(j)
                delta = 1;

                for t = 1:CNLen(j)

                    if (CNSet(j, k) ~= CNSet (j, t))
                        delta = delta * (1 - 2 * messQ1(j, CNSet(j, t)));
                    end

                end

                messR0(j, CNSet(j, k)) = 0.5 + 0.5 * delta;
                messR1(j, CNSet(j, k)) = 1 - messR0(j, CNSet(j, k));
            end

        end

        for j = 1:N

            for k = 1:VNLen(j)
                alpha1 = 1;
                alpha2 = 1;
                alpha = 1;

                for t = VNLen(j)

                    if (VNSet(j, k) ~= VNSet(j, t))
                        alpha1 = alpha1 * messR0(VNSet(j, t), j);
                        alpha2 = alpha2 * messR1(VNSet(j, t), j);
                    end

                end

                alpha = 1 / (p0(j) * alpha1 + p1(j) * alpha2);
                messQ0(VNSet(j, k), j) = alpha * p0(j) * alpha1;
                messQ1(VNSet(j, k), j) = alpha * p1(j) * alpha2;
            end

        end

        %
        Q0 = zeros(1, N); Q1 = zeros(1, N);

        for j = 1:N
            gama1 = 1; gama2 = 1; gama = 1;

            for k = 1:VNLen(j)
                gama1 = gama1 * messR0(VNSet(j, k), j);
                gama2 = gama2 * messR1(VNSet(j, k), j);
            end

            gama = 1 / (p0(j) * gama1 + p1(j) * gama2);
            Q0(j) = gama * p0(j) * gama1;
            Q1(j) = gama * p1(j) * gama2;
        end

        %
        for j = 1:N

            if (Q0(j) >= 0.5)
                decodeWord(j) = 0;
            else
                decodeWord(j) = 1;
            end

        end

        %
        CH = mod(double(H) * decodeWord', 2);

        if (CH == 0)
            success = 1;
            break;
        end

    end

    dec = decodeWord(1:N - M);

end
