function [x, vld] = gflineq(a, b, p)
vld = 0;
% construct an [A, B] matrix and assign initial value
aa = [a b];
x = aa(:);
if ((max(x) >=p) | (min(x) < 0) | ~isempty(find(floor(x) ~= x)))
    error('Element in A or B exceeded the defined field')
end;
[n, m] = size(aa);
k = 1;
i = 1;
ii = [];
kk = [];

% forward major element selection
while (i <= n) & (k < m)
    % make the diagonal element be one or jump one line.
    while (aa(i,k) == 0) & (k < m)
        ind = find(aa(i:n, k) ~= 0);
        if isempty(ind)
            k = k + 1;
        else
            indx = find(aa(i:n, k) == 1);
            if isempty(indx)
               ind_major = ind(1);
            else
               ind_major = indx(1);
            end;
            j = i + ind_major - 1;
            tmp = aa(i, :);
            aa(i,:) = aa(j, :);
            aa(j, :) = tmp;
        end;
    end;

    % clear all non-zero elements in the collumn except the major element.
    if (aa(i,k) ~= 0)
     % to make major element to be one.
        if (aa(i,k) ~= 1)
           aa(i,:) = rem(aa(i,k)^(p-2) * aa(i,:), p);
        end;
        ind = find(aa(:,k) ~= 0)';
        ii = [ii i];
        kk = [kk k];
        vec = [k:m];
        for j = ind
            if j ~= i
                % to make sure the column will be zero except the major element.
                aa(j, vec) = rem(aa(j, vec) + aa(i, vec) * (p - aa(j, k)), p);
            end;
        end;
        k = k + 1;
    end;
    i = i + 1;
end;

x = zeros(m-1, 1);

% the case of no solution
if (i <= n)
    % The case no solution
    ind = find(aa(i:n,m) ~= 0);
    if ~isempty(ind)
        disp('*** Your linear equation has no solution');
        return;
    end;
end

if (rank(aa) > rank(aa(:, 1 : m-1)))
    disp('*** Your linear equation has no solution');
    return;
end;

% The solution
len_kk = length(kk);
if max(kk(1:len_kk)) > n
    disp('*** Your linear equation has no solution');
else
    x(kk(1:len_kk)) = aa(ii(1:len_kk), m);
    vld = 1;
end;


