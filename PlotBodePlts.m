function PlotBodePlts(trialsMtrx)
%PlotBodePlts plots bode plot for each trial in rows of trialMtrx.
%   The function accepts matrix of trials, where each row contains mass in
%   column 1, spring constant in column 2, and damping constant in column 3.
%   The function plots absolute gain vs. normalized frequency plot and
%   phase shift vs. normalized frequency plot for each of those trials.
%   300 points are used to make Bode plots.
%   All trials are plotted on the same plot using different colors.
%   Normalized frequency axis is logarithmic from 0.1 to 10.
%   The function does not return anything.
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Error check that trialsMtrx has the number of columns equal to 3 and
%   number of rows not less than 1
if size(trialsMtrx,2) ~= 3 || size(trialsMtrx,1) < 1
    error('Error: trialsMtrx must have 3 columns and at least 1 row\n')
end % End trialsMtrx check

%   Error check that all inputs are numeric
if sum(~isnumeric(trialsMtrx),"all")
    error('Error: All inputs must be numeric\n')
end % End numeric check

%   Error check that all inputs are real
if sum(~isreal(trialsMtrx),"all")
    error('Error: All inputs must be real\n')
end % End real check

%   Error check that first and second column of trialsMtrx are greater than 0
if sum(trialsMtrx(:,1)<=0) || sum(trialsMtrx(:,2)<=0)
    error('Error: Masses and spring constants must be greater than 0\n')
end % End greater than 0 check

%   Error check that third column of trialsMtrx is greater than or equal to 0
if sum(trialsMtrx(:,3)<0)
    error('Error: Damping constants must be 0 or greater\n')
end % End greater than or equal to 0 check

%   Get number of trials
numTrials = size(trialsMtrx,1);

%   Preallocate matrices to store absolute gain and phase shift values for
%   each trial. Matricies must be the same number of rows as trialsMtrx and
%   have 300 columns.
absGainMtrx = zeros(numTrials,300);
phaseShiftMtrx = zeros(numTrials,300);

%   Preallocate vector to store xi values for all trials
xiVec = zeros(1,numTrials);

%   Create logarithmic vector of 300 normalized frequencies from 0.1 to 10
lambdaVec = logspace(-1,1,300);

%   For each row in trialsMtrx
for row=1:1:numTrials
    
    %   Get mass, spring constant, and damping constant
    m = trialsMtrx(row,1);
    k = trialsMtrx(row,2);
    c = trialsMtrx(row,3);

    %   Calculate xi value for the current row
    xiVec(row) = (c/2)*sqrt(1/(m*k));

    %   Calculate vector of 300 absolute gain values
    absGainVec = 1./sqrt((1-lambdaVec.^2).^2+(2*xiVec(row)*lambdaVec).^2);
    %   Store absolute gain vector for this trial in its corresponding row
    absGainMtrx(row,:) = absGainVec;

    %   Calculate vector of 300 phase shift values
    phaseShiftVec = -atan(2*xiVec(row)*lambdaVec./(1-lambdaVec.^2))*180/pi;
    %   Store phase shift vector for this trial in its corresponding row
    phaseShiftMtrx(row,:) = phaseShiftVec;

end % End for loop for all rows in trialsMtrx

%   Create vector of RGB triplet colors for all 8 trials
rgbColorsVec = [0, 0, 1; 0.8500, 0.3250, 0.0980; 0.9290, 0.6940, 0.1250; 0.4940, 0.1840, 0.5560; 0.4660, 0.6740, 0.1880; 0.3010, 0.7450, 0.9330; 0.6350, 0.0780, 0.1840; 0, 0, 0];

%   Start plotting function gain
figure(12)

%   For each row in absGainMtrx
for row = 1:1:size(absGainMtrx,1)
    %   Plot each curve on log x scale
    semilogx(lambdaVec,absGainMtrx(row,:),'Color',rgbColorsVec(row,:),'LineWidth',2)
    hold on
    grid on
end % End plotting each curve for absolute gain

%   Set title
title("Bode Plot: Absolute Gain",'FontSize',24)
%   Set axes boundaries
xlim([min(lambdaVec), max(lambdaVec)])
ylim([min(min(absGainMtrx)), max(max(absGainMtrx))])
% Set position on monitor
set(gcf,'Position',[75 75 1275 600])
% Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
% Set axes labes
xlabel("Normalized Frequency 0.1\omega/\omega_n\leqx\leq10\omega/\omega_n")
ylabel('Amplification Factor')
% Set legend
legend('Trial 1 \xi=0.04','Trial 2 \xi=1.59','Trial 3 \xi=1','Trial 4 \xi=1.24','Trial 5 \xi=0.16','Trial 6 \xi=1.26','Trial 7 \xi=1','Trial 8 \xi=0.13')

%   Start plotting phase shift
figure(13)

%   For each row in phaseShiftMtrx
for row = 1:1:size(phaseShiftMtrx,1)
    %   Plot each curve on log x scale
    semilogx(lambdaVec,phaseShiftMtrx(row,:),'Color',rgbColorsVec(row,:),'LineWidth',2)
    hold on
    grid on
end % End plotting each curve for phase shift

%   Set title
title("Bode Plot: Phase Shift",'FontSize',24)
%   Set axes boundaries
xlim([min(lambdaVec), max(lambdaVec)])
ylim([min(min(phaseShiftMtrx)), max(max(phaseShiftMtrx))])
% Set position on monitor
set(gcf,'Position',[75 75 1275 600])
% Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
% Set axes labes
xlabel("Normalized Frequency 0.1\omega/\omega_n\leqx\leq10\omega/\omega_n")
ylabel('Phase (Degrees)')
% Set legend
legend('Trial 1 \xi=0.04','Trial 2 \xi=1.59','Trial 3 \xi=1','Trial 4 \xi=1.24','Trial 5 \xi=0.16','Trial 6 \xi=1.26','Trial 7 \xi=1','Trial 8 \xi=0.13','NumColumns',2,'Location','best')

%   Draw all plots
drawnow

end % End of PlotBodePlts