clear;

close

load wind
xmin = min(x(:));
xmax = max(x(:));
ymax = max(y(:));
zmin = min(z(:));

wind_speed = sqrt(u.^2 + v.^2 + w.^2);
hsurfaces = slice(x,y,z,wind_speed,[xmin,100,xmax],ymax,zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap jet

return

clear;

L  = 10;           % length
nx = 50;
ny = 50;
nz = 20;

x = linspace(-2,2, nx);
y = linspace(-3,3, ny);
z = linspace(0, 1, nz);

[X,Y,Z] = meshgrid(x,y,z);

u = sin(pi*X).*cos(pi*Y) + sin(pi*Z);
u = randn(size(X)) .*sin(pi*Z) + sin(10*pi*X)/10 + Y.*cos(pi*Y);

xmin = min(x(:));
xmax = max(x(:));
ymax = max(y(:));
zmin = min(z(:));

hsurfaces = slice(X,Y,Z,u,[xmin,(xmax+xmin)/2,xmax],ymax,zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap jet

xlabel x; ylabel y; zlabel z;


ufft = fftn(u);
re    = real(ufft);
im    = imag(ufft);

phase = atan2(im, re);
amp   = sqrt(re.^2 + im.^2);

return


% [X,Y,Z,u] = flow;
p = patch(isosurface(X,Y,Z,u,0.5));
isonormals(X,Y,Z,u,p)
p.FaceColor = 'red';
p.EdgeColor = 'none';
daspect([1,1,1])
view(3); axis tight
camlight 
lighting gouraud
