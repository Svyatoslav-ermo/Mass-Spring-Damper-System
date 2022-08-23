function PlotPosVsTime(x1H,x1I,x2H,x2I,x4H,x4I,t,trial)
%PlotPosVsTime Function plots 6 subplots of position vector vs. time vector.
%   The function accepts 6 vectors of position x and time domain vector t as
%   well as trial number. It plots x vs. t for each Runge-Kutta method
%   both homogeneous and inhomogeneous cases as 6 subplots on 1 plot.
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Error check that inputs are numeric and real
if sum(~isnumeric(x1H)) || sum(~isnumeric(x1I)) || sum(~isnumeric(x2H)) || sum(~isnumeric(x2I)) || sum(~isnumeric(x4H)) || sum(~isnumeric(x4I))
    error('Error: Inputs must be numeric and real\n')
end

if sum(~isreal(x1H)) || sum(~isreal(x1I)) || sum(~isreal(x2H)) || sum(~isreal(x2I)) || sum(~isreal(x4H)) || sum(~isreal(x4I))
    error('Error: Inputs must be numeric and real\n')
end

if sum(~isnumeric(t)) || sum(~isreal(t)) || ~isnumeric(trial) || ~isreal(trial)
    error('Error: Inputs must be numeric and real\n')
end % End numeric and real check

%   Error check that x and t are vectors of the same size
if length(x1H) ~= length(t) || length(x1I) ~= length(t) || length(x2H) ~= length(t) || length(x2I) ~= length(t) || length(x4H) ~= length(t) || length(x4I) ~= length(t)
    error('Error: x and t must be the same size vectors\n')
end % End length check

%   Create figure
figure(trial)

%   Plot first subplot
subplot(3,2,1)
hold on % Keep figure
grid on % Turn grid on
%   Plot position vs. time
plot(t,x1H,'b','LineWidth',3)
%   Set axes limits
xlim([min(t) max(t)])
ylim([min(x1H) max(x1H)])
title('First-order Homogeneous','FontSize',24)
% Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
% Set axes labes
xlabel('Time (s)')
ylabel('Position (m)')

%   Plot second subplot
subplot(3,2,3)
hold on % Keep figure
grid on % Turn grid on
%   Plot position vs. time
plot(t,x2H,'r','LineWidth',3)
%   Set axes limits
xlim([min(t) max(t)])
ylim([min(x2H) max(x2H)])
title('Second-order Homogeneous','FontSize',24)
% Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
% Set axes labes
xlabel('Time (s)')
ylabel('Position (m)')

%   Plot third subplot
subplot(3,2,5)
hold on % Keep figure
grid on % Turn grid on
%   Plot position vs. time
plot(t,x4H,'g','LineWidth',3)
%   Set axes limits
xlim([min(t) max(t)])
ylim([min(x4H) max(x4H)])
title('Fourth-order Homogeneous','FontSize',24)
% Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
% Set axes labes
xlabel('Time (s)')
ylabel('Position (m)')

%   Plot fourth subplot
subplot(3,2,2)
hold on % Keep figure
grid on % Turn grid on
%   Plot position vs. time
plot(t,x1I,'c','LineWidth',3)
%   Set axes limits
xlim([min(t) max(t)])
ylim([min(x1I) max(x1I)])
title('First-order Inhomogeneous','FontSize',24)
% Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
% Set axes labes
xlabel('Time (s)')
ylabel('Position (m)')

%   Plot fifth subplot
subplot(3,2,4)
hold on % Keep figure
grid on % Turn grid on
%   Plot position vs. time
plot(t,x2I,'m','LineWidth',3)
%   Set axes limits
xlim([min(t) max(t)])
ylim([min(x2I) max(x2I)])
title('Second-order Inhomogeneous','FontSize',24)
% Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
% Set axes labes
xlabel('Time (s)')
ylabel('Position (m)')

%   Plot sixth subplot
subplot(3,2,6)
hold on % Keep figure
grid on % Turn grid on
%   Plot position vs. time
plot(t,x4I,'y','LineWidth',3)
%   Set axes limits
xlim([min(t) max(t)])
ylim([min(x4I) max(x4I)])
title('Fourth-order Inhomogeneous','FontSize',24)
%   Set axes line width and font size
set(gca,'LineWidth',3,'FontSize',20)
%   Set axes labes
xlabel('Time (s)')
ylabel('Position (m)')

%   Set position on monitor
set(gcf,'Position',[75 75 1775 900])

%   Set main title
sgtitle("Position over time for trial #" + trial,'FontSize',24)
%text(-5,8.75,"Position over time for trial #" + trial,'FontSize',24)

%   Draw all plots
drawnow

end % End of PlotPosVsTime