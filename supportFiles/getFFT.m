function [u, pha, amp] = getFFT(u)

% m   = nextpow2(size(u));
% u   = fftn(u, 2.^m);
u = fftn(u);

UR  = real(u);
UI  = imag(u);

pha = atan2(UI, UR);
amp = sqrt(UI.^2 + UR.^2) / numel(u);

end
