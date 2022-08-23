function fVal = f(t,m,a0)
%f function calculates forcing function over mass: a0*sin(t/(2pi))/m
%   The function calculates forcing function over mass for time t. The
%   function accepts time t, mass m, and initial force a0. The function
%   returns the forcing function over mass value.
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   Error check that all inputs are numeric and real
if ~isnumeric(t) || ~isnumeric(m) || ~isnumeric(a0) || ~isreal(t) || ~isreal(m) || ~isreal(a0)
    error('Error: All inputs must be numeric and real\n')
end % End numeric and real check

%   Error check that mass is not less than or equal to 0
if m <= 0
    error('Error: m must be positive\n')
end % End m check

%   Error check that time is not less than 0
if t < 0
    error('Error: t must be 0 or positive\n')
end % End t check

%   Calculate the forcing function over mass
fVal = a0*sin(t/(2*pi))/m;

end % End of f