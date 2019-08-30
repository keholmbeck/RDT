clear;

L  = 2*pi;
K0 = 2*pi / L;
n  = [4,2,0]';

K  = K0 .* n;
return

K  = orth( K0 .* n );

x  = linspace(-2*pi, 2*pi, 10)';
[x1,x2,x3] = deal(x);

n   = 1i * K;
tmp = exp(n(1)*x1) .* exp(n(2)*x2) .* exp(n(3)*x3);
return

kp = 12;
k = 2*pi*rand(1,3);
A = rand(100,1);
E = bsxfun(@times, A, k.^4.*exp(-2*k.^2./kp.^2));
tmp = ifft(E);

nx = 10;
ny = 10;
nz = 10;

x = linspace(0,2*pi, nx);
y = linspace(0,2*pi, ny);
z = linspace(0,2*pi, nz);

[X,Y,Z] = meshgrid(x,y,z);

U = sin(2*Y).*cos(Z);
V = cos(3*X).*cos(5*Z);
W = 2*X;

divU = divergence(X,Y,Z,U,V,W);

plotField(X,Y,Z, divU); colorbar
% return

% ufft, pha, amp --> not guaranteed to be the size of u
[ufft, pha, amp] = getFFT(U);

figure; plotField(pha); title Phase FontW B
figure; plotField(amp); title Amplitude FontW B

