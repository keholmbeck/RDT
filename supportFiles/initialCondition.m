function [U,V,W] = initialCondition(X,Y,Z)

% U = randn(size(X));
% V = randn(size(Y));
% W = randn(size(Z));
% return

U = sin(2*Y).*cos(Z);
V = cos(3*X).*cos(5*Z);
W = 2*X;

siz = (size(Y));
U = randn(siz);
V = randn(siz);
W = 0*randn(siz);


% U = fftn(U); V = fftn(V); W = fftn(W);
return

AMP = randn(size(X));

THETA = 2*pi * rand(size(X));
V = AMP.*exp(1i*THETA);

THETA = 2*pi * rand(size(X));
U = AMP.*exp(1i*THETA);

THETA = 2*pi * rand(size(X));
W = AMP.*exp(1i*THETA);

end
