x = [0 1];
y = [1 1];
numSteps = 100;
% Calculate the trajectory by linear interpolation of the x and y coordinate.
trajectory = [ linspace(x(1),x(2),numSteps); linspace(y(1),y(2),numSteps) ];
% Make figure with axes.
figure; axis square;
set(gca,'XLim',[-2 2], 'YLim', [-2 2]);
% Make the moving point object, starting at point [x(1), y(1)].
movingPoint = rectangle( 'Parent', gca, 'Position', [x(1), y(1), .1, .1], 'Curvature', [1 1] );
% Make the frames for the movie.
for frameNr = 1 : numSteps
  set( movingPoint, 'Position', [trajectory(1,frameNr), trajectory(2,frameNr), .1, .1] );
  frames(frameNr) = getframe;
end