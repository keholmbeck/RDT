function [U,V,W] = convert_uhat_to_u(U,V,W, k,t, PTS)

% k{2} = permute(k{2}(:), [4,3,2,1]);

tmp = zeros(1, 3, length(t));
tmp(:,1,:) = k{1};
tmp(:,2,:) = k{2};
tmp(:,3,:) = k{3};

N   = round( size(PTS, 1) ^ (1/3) );

ktmp = exp(1i * bsxfun(@times,PTS,tmp));
ktmp = prod(ktmp, 2);
ktmp = reshape(ktmp, [N,N,N, length(t)]);

U1 = bsxfun(@times, U, ktmp);
V1 = bsxfun(@times, V, ktmp);
W1 = bsxfun(@times, W, ktmp);

ktmp = exp(-1i * bsxfun(@times,PTS,tmp));
ktmp = prod(ktmp, 2);
ktmp = reshape(ktmp, [N,N,N, length(t)]);

U2 = bsxfun(@times, conj(U), ktmp);
V2 = bsxfun(@times, conj(V), ktmp);
W2 = bsxfun(@times, conj(W), ktmp);

U = U1 + U2;
V = V1 + V2;
W = W1 + W2;

return

U = U + conj(U);
V = V + conj(V);
W = W + conj(W);
end


