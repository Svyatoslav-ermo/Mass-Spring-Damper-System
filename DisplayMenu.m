function DisplayMenu()
%DisplayMenu displays menu of options on the screen.
%   The function displays all menu options on the screen on separate lines.
%   The options are for trials 1-8, and 9th option is displaying bode plots
%   for all trials. Function does not accept nor return anything.
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%   Display all trials 1-8 with their conditions on separate lines
fprintf('\nMenu of choices:\n')
fprintf('Mass (m) in kg, spring constant (k) in N/m, damping ratio (c) in N*s/m\n')
fprintf('-------------------------------------------------------------------------\n')
fprintf('1: Make plots for m = 3, k = 200, c = 2\n')
fprintf('2: Make plots for m = 4, k = 50, c = 45\n')
fprintf('3: Make plots for m = 5, k = 125, c = 50\n')
fprintf('4: Make plots for m = 8, k = 25, c = 35\n')
fprintf('5: Make plots for m = 10, k = 100, c = 10\n')
fprintf('6: Make plots and video for over-damped vibration using m = 2, k = 5, c = 8\n')
fprintf('7: Make plots and video for critically-damped vibration using m = 3, k = 12, c = 12\n')
fprintf('8: Make plots and video for under-damped vibration using m = 5, k = 200, c = 8\n')
fprintf('9: Make two Bode plots (absolute gain and phase shift) for all trials 1-8\n')
fprintf('''q'': Quit the program\n')
end % End of DisplayMenu