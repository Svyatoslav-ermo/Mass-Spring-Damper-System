function x = VibrationPosition(x0,m,k,c,f,dt,type)
%VibrationPosition calculates position and velocity at step k+1.
%   Function accepts the following inputs:
%      x0   - 1x2 vector of position x and velocity v at step k [x,v]
%      m    - mass of the body on  the spring
%      k    - spring constant
%      c    - damping constant
%      f    - 1x3 forcing function vector [f(t),f(t+0.5dt),f(t+dt)]
%      dt   - time step
%      type - type of Runge-Kutta method, 1 for first-order, 2 for
%             second-order, 4 for fourth order
%   Function returns new position and velocity [x,v] at step k+1
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%   Error check that all inputs are numeric
if sum(~isnumeric(x0)) || ~isnumeric(m) || ~isnumeric(k) || ~isnumeric(c) || sum(~isnumeric(f)) || ~isnumeric(dt) || ~isnumeric(type)
    error('Error: Inputs must be numeric\n')
end % End numeric check

%   Error check that all inputs are real
if sum(~isreal(x0)) || ~isreal(m) || ~isreal(k) || ~isreal(c) || sum(~isreal(f)) || ~isreal(dt) || ~isreal(type)
    error('Error: Inputs must be real\n')
end % End real check

%   Error check that x0 is 1x2 vector and f is 1x3 vector
if length(x0) ~= 2 || length(f) ~= 3
    error('Error: x0 and f must be 1x2 and 1x3 vectors, respectively\n')
end % End x0 and f check

%   Error check that m and k are not less than or equal to 0
if m <= 0 || k <= 0
    error('Error: m and k can only be positive\n')
end % End m and k check

%   Error check that c is not negative
if c < 0
    error('Error: c can only be positive or 0\n')
end % End c check
%=====================================================================

%   Set xk and vk
xk = x0(1);
vk = x0(2);

%   Find natural frequency (omega) and damping ratio (xi)
omega = sqrt(k/m);
xi = (c/2)*sqrt(1/(m*k));

%   Start switch statement for Runge-Kutta methods
switch(type)
%=====================================================================

    %   If type is 1
    case (1)
        %   Perform first-order Runge-Kutta (aka forward Euler)
        cx1 = dt*vk;
        cv1 = dt*(-2*xi*omega*vk-omega^2*xk+f(1));
        x(1) = xk+cx1; % Find position at k+1
        x(2) = vk+cv1; % Find velocity at k+1
%=====================================================================

    %   If type is 2
    case(2)
        %   Perform second-order Runge-Kutta
        cx1 = dt*vk;
        cv1 = dt*(-2*xi*omega*vk-omega^2*xk+f(1));
        cx2 = dt*(vk+0.5*cv1);
        cv2 = dt*(-2*xi*omega*(vk+0.5*cv1)-omega^2*(xk+0.5*cx1)+f(2));
        x(1) = xk+cx2; % Find position at k+1
        x(2) = vk+cv2; % Find velocity at k+1
%=====================================================================

    %   If type is 4
    case(4)
        %   Perform fourth-order Runge-Kutta
        cx1 = dt*vk;
        cv1 = dt*(-2*xi*omega*vk-omega^2*xk+f(1));
        cx2 = dt*(vk+0.5*cv1);
        cv2 = dt*(-2*xi*omega*(vk+0.5*cv1)-omega^2*(xk+0.5*cx1)+f(2));
        cx3 = dt*(vk+0.5*cv2);
        cv3 = dt*(-2*xi*omega*(vk+0.5*cv2)-omega^2*(xk+0.5*cx2)+f(2));
        cx4 = dt*(vk+cv3);
        cv4 = dt*(-2*xi*omega*(vk+cv3)-omega^2*(xk+cx3)+f(3));
        x(1) = xk+(1/6)*(cx1+2*cx2+2*cx3+cx4); % Find position at k+1
        x(2) = vk+(1/6)*(cv1+2*cv2+2*cv3+cv4); % Find velocity at k+1
%=====================================================================

    %   Else type is wrong
    otherwise
        error('Error: type can only be 1, 2, or 4\n')
%=====================================================================

end % End swtich statement for Runge-Kutta methods

end % End of VibrationPosition