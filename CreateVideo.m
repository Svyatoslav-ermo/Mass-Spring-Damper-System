function CreateVideo(xH,xI,t,fps,videoName,trial)
%CreateVideo Function animates homogeneous and inhomogeneous responses.
%   The function creates animation plot consisting of two subplots. The
%   left one using homogeneous response, and the right one inhomogeneous.
%   The function accepts homogeneous position vector xH, inhomogeneous
%   position vector xI, frames per second fps, video name, and the
%   trial number. The animation is created by advancing through all time
%   domain values, creating the video that is length(t)/fps seconds long.
%   The function does not return anything.
%
%   Author: Slava Ermolaev
%   08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Error check that all input vectors are numeric
if sum(~isnumeric(xH)) || sum(~isnumeric(xI)) || sum(~isnumeric(t)) || ~isnumeric(fps)
    error('Error: Input vectors must be numeric\n')
end % End numeric check

%   Error check that all input vectors are real
if sum(~isreal(xH)) || sum(~isreal(xI)) || sum(~isreal(t)) || ~isnumeric(fps)
    error('Error: Input vectors must be real\n')
end % End real check

%   Error check that fps is creater than 0
if fps <= 0
    error('Error: fps must be positive\n')
end % End fps check

%   Error check that videoName is a string
if ~isstring(videoName)
    error('Error: videoName must be a string\n')
end % End videoName check

%   Error check that all vectors are equal in size
if length(xH) ~= length(xI) || length(xI) ~= length(t)
    error('Error: All vector inputs must be equal in size\n')
end % End vector length check

%   Set figure number depending on the trial
%   The function assumes only trials 6-8 as shown in if statements
if trial == 6
    figureNum = 9;
    mainTitle = "Over-damped vibration (\xi > 1)";
elseif trial == 7
    figureNum = 10;
    mainTitle = "Critically-damped vibration (\xi = 1)";
elseif trial == 8
    figureNum = 11;
    mainTitle = "Under-damped vibration (\xi < 1)";
else
    error('Error: trial must be 6, 7, or 8.\n')
end % Emd figure and main title set

%   Create video_file object
video_file = VideoWriter(videoName,'MPEG-4');
video_file.FrameRate = fps;  % Set video frame rate
open(video_file) % Open video_file to write

%   Set squares Y coordinates
    squareY = [-0.5, -0.5, 0.5, 0.5, -0.5]; % Y coordinates for both squares are the same

%   For each x on time domain
for k = 1:1:length(t)

    %   Create figure for the plot
    figure(figureNum)

    %   Set square of length 1 for homogeneous plot with the center at [xH(1),0]
    xLeftH = xH(k)-0.5; % Left x coordinate
    xRightH = xH(k)+0.5; % Right x coordinate
    squareXH = [xLeftH, xRightH, xRightH, xLeftH, xLeftH]; % homogeneous square x coordinates

    %   Set square of length 1 for inhomogeneous plot with the center at [xI(1),0]
    xLeftI = xI(k)-0.5;
    xRightI = xI(k)+0.5;
    squareXI = [xLeftI, xRightI, xRightI, xLeftI, xLeftI]; % inhomogeneous square x coordinates

    %   Plot homogeneous plot on the first subplot
    subplot(1,2,1)  % 1st Subplot in [1,1] position
    plot(squareXH, squareY, 'b-', 'LineWidth', 3);
    %   Set main title
    text(0.55,2,mainTitle,'FontSize',24)
    %   Create time string with time rounded to 1 digit after decimal
    timeText = sprintf('Time = %.1f seconds', t(k));
    %   Display time string with current time
    text(1.25,1.6,timeText,'FontSize',24)
    %   Set equal aspect ratio
    axis equal
    %   Turn grid on
    grid on
    %   Set title for first subplot
    title('Homogeneous Response','FontSize',24)
    %   Set axes limits
    xlim([-2 2])
    ylim([-1 1])
    %   Format axes
    set(gca,'LineWidth',3,'FontSize',20)
    xlabel('X axis')
    ylabel('Y axis')

    %   Plot inhomogeneous plot in the second subplot
    subplot(1,2,2)  % 2nd Subplot in [1,2] position
    plot(squareXI, squareY, 'r-', 'LineWidth', 3);
    %   Set equal aspect ratio
    axis equal
    %   Turn grid on
    grid on
    %   Set title
    title('Inhomogeneous Response','FontSize',24)
    %   Set axes limits
    xlim([-2 2])
    ylim([-1 1])
    %   Format axes
    set(gca,'LineWidth',3,'FontSize',20)
    xlabel('X axis')
    ylabel('Y axis')

    %   Set position on monitor
    set(gcf,'Position',[75 75 1275 600])
    
    %   Capture Current Frame
    current_frame = getframe(gcf);
    %   Record Current Frame
    writeVideo(video_file,current_frame);

end % End of for loop for all x values in time domain

close(video_file) % Close video_file


end % End of CreateVideo