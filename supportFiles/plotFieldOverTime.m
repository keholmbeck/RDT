function mov = plotFieldOverTime(fname)

if nargin == 0
    load totU.mat;
else
    load(fname);
end

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


for ii = 1:3:length(t)
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
    title(sprintf('t = %0.3f\n U', t(ii)), 'FontW', 'B');
    caxis(CAX(1,:)); colorbar
    
    subplot(132)
    fh = plotField(X,Y,Z,V(:,:,:,ii));
    title(sprintf('V'), 'FontW', 'B');
    caxis(CAX(2,:)); colorbar
    
    subplot(133)
    fh = plotField(X,Y,Z,W(:,:,:,ii));
    title(sprintf('W'), 'FontW', 'B');
    caxis(CAX(3,:)); colorbar
    
    drawnow; pause(0.05);
    
    mov(ii) = getframe(gcf);
end

return
tmp = VideoWriter('example.avi');
open(tmp);
writeVideo(tmp, mov);
close(tmp);

end