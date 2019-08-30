function fh = plotField(X,Y,Z, u)

if nargin == 1
    u = X;
    siz = size(u);
    [X,Y,Z] = meshgrid(1:siz(2), 1:siz(1), 1:siz(3));
end

fh = figure(gcf);

xmin = min(X(:));
xmax = max(X(:));
ymax = max(Y(:));
ymin = min(Y(:));
zmin = min(Z(:));

hsurfaces = slice(X,Y,Z,u,[xmin,(xmax+xmin)/2,xmax],[ymin, ymax],zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap jet
xlabel x; ylabel y; zlabel z;

end