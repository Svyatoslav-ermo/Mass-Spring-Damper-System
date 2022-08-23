function x = SolveResponseX(x0,m,k,c,dt,type,a0,t,solnType)
%SolveResponseX Solves for vector of positions over time.
%   The function solves for positions of mass body over time domain t.
%   Function accepts initial conditions x0 = [position,velocity], mass m,
%   spring constant k, damping ratio c, time step dt, type (1,2, or 4) of
%   Runge-Kutta method, initial force a0, time domain vector t, and
%   solnType (0 for homogeneous or 1 for inhomogeneous. Function iterates
%   through time domain t to solve for new position by calling
%   VibrationPosition function. Function returns vector of positions x over
%   all values of time domain vector t.
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Perform error check for x0, dt, a0, t, and solnType. The rest of inputs are
%   not used in this function and are checked in VibrationPosition.

%   Error check that a0, t, and solnType are numeric
if sum(~isnumeric(x0)) || ~isnumeric(dt) || ~isnumeric(a0) || sum(~isnumeric(t)) || ~isnumeric(solnType)
    error('Error: dt, a0, t, and solnType must be numeric\n')
end % End numeric check

%   Error check that x0, dt, a0, t, and solnType are real
if sum(~isreal(x0)) || ~isreal(dt) || ~isreal(a0) || sum(~isreal(t)) || ~isreal(solnType)
    error('Error: dt, a0, t, and solnType must be real\n')
end % End real check

%   Error check that solnType is 0 or 1
if solnType ~= 0 && solnType ~= 1
    error('Error: solnType must be either 0 or 1\n')
end % End solnType check

%   Error check that x0 is a vector of length 2
if length(x0) ~= 2
    error('Error: x0 must have length of 2\n')
end % End x0 length check

%   Preallocate vector of 3 zeros to hold forcing function outputs:
%   [f(t),f(t+0.5dt),f(t+dt)]
fVec = zeros(1,3);

%   Preallocate vector x the same size as t with zeros
x = zeros(1,length(t));

%   Store initial position in first position of x
x(1) = x0(1);

%   For all time domain
for i=1:1:length(t)-1
    
    %   If solnType is 1
    if solnType == 1
        %   Solve for forcing function outputs using current time t(i)
        fVec(1) = f(t(i),m,a0);
        fVec(2) = f(t(i)+0.5*dt,m,a0);
        fVec(3) = f(t(i)+dt,m,a0);
    end % End forcing function if statement

    %   Call VibrationPosition to calculate new position and velocity
    %   vector. Update x0 with new vector output from the function call.
    x0 = VibrationPosition(x0,m,k,c,fVec,dt,type);

    %   Store new position at i+1'th of vector x
    x(i+1) = x0(1);

end % End for loop for all time domain values

end % End of SolveResponseX