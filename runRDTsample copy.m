clear;
rng(1028);

% %{
h           = 0.1;                      % step size
t           = linspace(0, 1, 100);
n           = 10;
grid        = pi*[-1, 1];

[X,Y,Z]     = makeGrid(grid, n);
[UI,VI,WI]  = initialCondition(X,Y,Z);

UI = fftn(UI);
VI = fftn(VI);
WI = fftn(WI);

%{
UI = fftn( real(ifftn(UI)) );
VI = fftn( real(ifftn(VI)) );
WI = fftn( real(ifftn(WI)) );
div = divergence(X,Y,Z,(UI),(VI),(WI));
return
%}

k       = randn(3,1);
S       = 1;
du      = @(t,u) rdtODE(t,u,k,S);

npts    = numel(X);
IC      = [UI(:), VI(:), WI(:)];
PTS     = [Y(:), X(:), Z(:)];

fprintf('Starting RK4 \n');
totU = zeros(npts*3, length(t));
siz = size(totU);

pdisp = npts/10;
pflag = 1;

for ii = 1:npts
    U      = zeros(length(t), 3);
    U(1,:) = IC(ii,:);
    U      = RK4(du, t, U, h, @(x,t) enforceSolenoidal(x,t,k));
    
    totU(ii+[0,npts,2*npts],:) = U';
    
    if ii >= pflag*pdisp
        fprintf('..%0.0f%s', ceil(100*ii/npts),'%');
        pflag = pflag + 1;
    end
end
fprintf('\n Finished RK4 \n');

k2t = (k(2) - S.*k(1).*t);

U = totU(1:npts,:);
V = totU(npts+1:2*npts,:);
W = totU(2*npts+1:end,:);

return

U = reshape(U, [size(X), length(t)]);
V = reshape(V, [size(X), length(t)]);
W = reshape(W, [size(X), length(t)]);

% making sum with conjugate modes to ensure real field
k2t = (k(2) - S.*k(1).*t);
k2t = permute(k2t(:), [4,3,2,1]);

tmp = bsxfun(@times,PTS,k');
tmp = exp(1i*tmp) + exp(-1i*tmp);
e       = exp(k*1i) + exp(-k*1i);
sumV    = bsxfun(@times, exp(k2t*1i)+exp(-k2t*1i), V);
tmp     = e(1)*U + sumV + e(3)*W;
% totU    = real(tmp);

save totU.mat;
return;
%}

load totU.mat

% U = real(U); V = real(V); W = real(W);

figure(gcf);
CAX = [min(U(:)), max(U(:));
       min(V(:)), max(V(:));
       min(W(:)), max(W(:))];

xmin = min(X(:));
xmax = max(X(:));
ymax = max(Y(:));
ymin = min(Y(:));
zmin = min(Z(:));


for ii = 1:length(t)
    %{
    CAX = [min(totU(:)), max(totU(:))];
    fh = plotField(X,Y,Z,totU(:,:,:,ii));
    title(sprintf('U \n t = %0.3f', t(ii)), 'FontW', 'B');
    caxis(CAX); colorbar;
    pause(0.1);
    mov(ii) = getframe(gcf);
    continue;
    %}
    
    subplot(131)
    fh = plotField(X,Y,Z,U(:,:,:,ii));
    title(sprintf('U \n t = %0.3f', t(ii)), 'FontW', 'B');
    caxis(CAX(1,:));
    
    subplot(132)
    fh = plotField(X,Y,Z,V(:,:,:,ii));
    title(sprintf('V'), 'FontW', 'B');
    caxis(CAX(2,:));
    
    subplot(133)
    fh = plotField(X,Y,Z,W(:,:,:,ii));
    title(sprintf('W'), 'FontW', 'B');
    caxis(CAX(3,:));
    
    pause(0.1);
    mov(ii) = getframe(gcf);
end

return
tmp = VideoWriter('example.avi');
open(tmp);
writeVideo(tmp, mov);
close(tmp);

