function points = chan2xyz(skel,channels)

% CHAN2XYZ Compute XYZ values for all frames given the structure and
% channels.
%
%	Description:
%
%	XYZ = CHAN2XYZ(SKEL, CHANNELS) Computes X, Y, Z coordinates given a
%	BVH skeleton structure and an associated set of channels. Channels can
%	store more than one time frame.
%	 Returns:
%	  XYZ - the point cloud positions for the skeleton for all time frames.
%	 Arguments:
%	  SKEL - a skeleton for the bvh file.
%	  CHANNELS - the channels for the bvh file.

temp = skel2xyz(skel,channels(1,:));

points = zeros(size(channels,1),length(temp(:)));
for i=1:size(channels,1),
    points(i,:) = reshape(skel2xyz(skel,channels(i,:))',1,[]);
end