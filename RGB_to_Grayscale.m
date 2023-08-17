%% convert a RGB video to a grayscale one.
% videoFReader = vision.VideoFileReader('C:\Users\46596\Desktop\Multi DDM\data\100MEDIA\DJI_0052.MP4');
% videoFWriter = vision.VideoFileWriter('C:\Users\46596\Desktop\Multi DDM\data\100MEDIA_Grayscale\DJI_0052_grayscale.MP4',...
%    'FrameRate',videoFReader.info.VideoFrameRate);
% while ~isDone(videoFReader)
%    videoFrame = step(videoFReader);
%    step(videoFWriter, rgb2gray(videoFrame));
% end
% release(videoFReader);
% release(videoFWriter);

vid = VideoReader('C:\Users\46596\Desktop\Multi DDM\data\100MEDIA\DJI_0052.MP4');
numImgs = get(vid, 'NumberOfFrames');
frames = read(vid);

for i=1:numImgs
  frames(:,:,:,i)=rgb2gray(frames(:,:,:,i));
end

