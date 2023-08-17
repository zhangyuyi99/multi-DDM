% Set the directory path
% dir_path = '\\sf3.bss.phy.private.cam.ac.uk\cicutagroup\yz655\wheat_videos\drone_videos\stabilized_drone_videos_to_run_Analysis\';
% dir_path = '\\sf3.bss.phy.private.cam.ac.uk\cicutagroup\yz655\wheat_videos\nott_videos\compressed_fps10_nott_videos_Analysis\';
dir_path = '\\sf3.bss.phy.private.cam.ac.uk\cicutagroup\yz655\wheat_videos\finn_videos\stabilized_to_run_Analysis\';
% Get a list of all the .mat files in the directory
mat_files = dir(fullfile(dir_path, '*.mat'));

% Open the output file for writing
fid = fopen('finn_videos.csv', 'w');

% Write the header row to the output file
fprintf(fid, ['Filename,Height,Width,NumFrames,Framerate,MedianFrequencyVec,Major_q,Major_q_amplitude,Major_q_frequency,Major_q_damping,Major_q_offset,Major_q_gof\n']);

% Loop through the .mat files
for i = 1:length(mat_files)
    % Load the file
    data = load(fullfile(dir_path, mat_files(i).name));
    
    % Get the height and width of the data
    height = data.cilia.Height;
    width = data.cilia.Width;
    num_frames = data.cilia.NumberOfFrames;
    framerate = data.cilia.FrameRate; 
    medianFrequencyVec = data.cilia.Results.MedianFrequencyVec;
    [major_q_amplitude,major_q] = max(data.cilia.Results.Box.Amplitude);
    major_q_frequency = data.cilia.Results.Box.Frequency(major_q);
    major_q_damping = data.cilia.Results.Box.Damping(major_q);
    major_q_offset = data.cilia.Results.Box.Offset(major_q);
    major_q_gof = data.cilia.Results.Box.GOF(major_q);

    
    % Write the data to the output file
    fprintf(fid, '%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n', mat_files(i).name, height, width, num_frames, framerate, medianFrequencyVec, major_q, major_q_amplitude, major_q_frequency, major_q_damping, major_q_offset, major_q_gof);
end

% Close the output file
fclose(fid);