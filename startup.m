
function startup()

format compact
format short

dbstop if error

set(0, 'DefaultLineLineWidth', 1.5);

tmp = {'DefaultAxesXGrid', 'DefaultAxesYGrid', 'DefaultAxesZGrid'};
for ii = 1:length(tmp)
    set(0, tmp{ii}, 'on');
end

addpath ./supportFiles
end
