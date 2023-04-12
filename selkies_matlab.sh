#!/bin/bash

#This script first pulls the Selkies-gstreamer image from Docker Hub and then runs the container in the background. It waits for 5 seconds to allow the Selkies-gstreamer server to start. 
Then, it starts MATLAB in non-interactive mode and runs the code to measure the FPS of the Selkies-gstreamer demo. Finally, it stops the video acquisition and exits MATLAB.



# Pull the Selkies-gstreamer image from Docker Hub
docker pull shanu10007/selkies-gstreamer

# Run the Selkies-gstreamer container
docker run --rm -p 5000:5000 -p 5001:5001 -e "DISPLAY=:0" -v /tmp/.X11-unix:/tmp/.X11-unix -it shanu10007/selkies-gstreamer /bin/bash &

# Wait for the Selkies-gstreamer server to start
sleep 5

# Start MATLAB
matlab -nodesktop -nosplash -r "

% Create a videoinput object that connects to the Selkies-gstreamer server
vid = videoinput('gstreamer', 'tcpclientsrc location=http://localhost:5000 ! decodebin ! videoconvert ! appsink', 'ConnectTimeout', 5);

% Set the frame rate of the videoinput object
vid.FramesPerTrigger = Inf;
vid.FrameGrabInterval = 1;

% Start the video acquisition
start(vid);

% Measure the FPS of the video acquisition
tic;
while true
    flushdata(vid);
    snapshot = getsnapshot(vid);
    imshow(snapshot);
    if toc >= 5
        break;
    end
end
fps = vid.FramesAcquired / toc;
fprintf('FPS: %f\n', fps);

% Stop the video acquisition
stop(vid);

% Exit MATLAB
exit;
"

