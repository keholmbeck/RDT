clear;

% MATLAB example: (R2015a)
load wind

% [verts,averts] = streamslice(x,y,z,u,v,w,[],[],[5]);
[verts,averts] = streamslice(u,v,w,[],[],[5]);

% return

sl = streamline([verts averts]);
ax = gca;

daspect([1,1,1]);

% iverts = interpstreamspeed(x,y,z,u,v,w,verts,.05);
iverts = interpstreamspeed(u, v, w, verts, 0.05);
zlim([4.9, 5.1]);
streamparticles(iverts, 200, ...
    'Animate',15,'FrameRate',40, ...
    'MarkerSize',10,'MarkerFaceColor',[0 .5 0])

% % % % % 

[sx, sy, sz] = meshgrid(80,20:10:50,0:5:15);
streamtube(x,y,z,u,v,w,sx,sy,sz);
% Define viewing and lighting
view(3)
axis tight
shading interp;
camlight; lighting gouraud
