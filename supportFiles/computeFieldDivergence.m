function div = computeFieldDivergence(X,Y,Z,U,V,W, k)

div = zeros(size(U));

for ii = 1:length(div)
    if nargin==6
        div(:,:,:,ii) = divergence(X,Y,Z, U(:,:,:,ii), V(:,:,:,ii), W(:,:,:,ii));
    else
        div(:,:,:,ii) = k(ii,1)*U(:,:,:,ii) + k(ii,2)*V(:,:,:,ii) + k(ii,3)*W(:,:,:,ii);
    end
end

end
