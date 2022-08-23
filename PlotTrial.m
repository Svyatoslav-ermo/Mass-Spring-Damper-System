function PlotTrial(trialsMtrx,trial,dt,x0,t,a0)
%PlotTrial Creates 6 plots of Runge-Kutta methods for homogeneous and
%inhomogeneous responses.
%   The function creates 6 position vs. time plots in total for each
%   Runge-Kutta method: first-order, second-order, and fourth order.
%   Each method plots homogeneous and inhomogeneous response. Function
%   accepts trialsMtrx that contains conditions for trials contained in
%   rows. First column is mass, second column is spring constant, third
%   column is damping constant. Function accepts trial that corresponds to
%   the row in trialsMtrx. Function also accepts initial conditions
%   x0=[position,velocity], time domain vector t, and initial force a0 for
%   inhomogeneous response.
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Error check that trial is numeric, integer, and greater than 0
if ~isnumeric(trial) || ~isreal(trial) || mod(trial,1) > 1e-14 || trial <= 0
    error('Error: trial must be numeric, real, and positive integer\n')
end % End of trial check

if size(trialsMtrx,1) < 1 || size(trialsMtrx,2) ~= 3
    error('Error: trialsMtrx must have 3 columns and at least 1 row\n')
end % End trialsMtrx size check

%   Set m, k, and c from trialsMtrx using trial as its row
m = trialsMtrx(trial,1);
k = trialsMtrx(trial,2);
c = trialsMtrx(trial,3);

%   Solve for first order homogeneous
x1H = SolveResponseX(x0,m,k,c,dt,1,a0,t,0);

%   Solve for first order inhomogeneous
x1I = SolveResponseX(x0,m,k,c,dt,1,a0,t,1);

%   Solve for second order homogeneous
x2H = SolveResponseX(x0,m,k,c,dt,2,a0,t,0);

%   Solve for second order inhomogeneous
x2I = SolveResponseX(x0,m,k,c,dt,2,a0,t,1);

%   Solve for fourth order homogeneous
x4H = SolveResponseX(x0,m,k,c,dt,4,a0,t,0);

%   Solve for fourth order inhomogeneous
x4I = SolveResponseX(x0,m,k,c,dt,4,a0,t,1);

%   Plot position vs. time for all 6 position vectors
PlotPosVsTime(x1H,x1I,x2H,x2I,x4H,x4I,t,trial)

end % End of PlotTrial