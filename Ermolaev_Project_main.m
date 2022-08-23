%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title: Final Project
%   Description: This script contains solution to the final project
%
%   This script, along with all the functions included, simulates
%   mass-spring-damper system for 8 trials. The program plots homogeneous
%   and inhomogeneous position vs. time responses for all trials using
%   first-order, second-order, and fourth-order Runge-Kutta approximations.
%   The program creates two bode plots of absolute gain and phase shift,
%   including all trials on the same axis. The program creates videos for
%   trials 6-8. Trial 6 demonstrates an over-damped vibration, trial 7
%   demonstrates a critically damped vibration, and trial 8 demonstrates an
%   under-damped vibration.
%
%   Author: Slava Ermolaev
%   Date: 08/12/2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clear Cache
clear all %#ok<*CLALL>
close all
clc

%%  Main script of Final Project

%   Set initial time
t0 = 0;

%   Set the final time
tf = 10;

%   Set frames per second
fps = 30;

%   Calculate the time step
dt = 1/fps;

%   Create a linear time domain vector to hold (tf/dt)+1 time values from t0 to tf
t = linspace(t0,tf,(tf/dt)+1);

%   Initialize vector of initial position and velocity [position,velocity]
x0 = [1, 0];

%   Set maximum force
a0 = 2.5;

%   Create and population matrix of trials. First column is mass, second
%   column is spring constant, third column is damping constant
trialsMtrx = [3, 200,  2;  % Trial 1
              4,  50, 45;  % Trial 2
              5, 125, 50;  % Trial 3
              8,  25, 35;  % Trial 4
             10, 100, 10;  % Trial 5
              2,   5,  8;  % Trial 6 (over-damped)
              3,  12, 12;  % Trial 7 (critically-damped)
              5, 200,  8]; % Trial 8 (under-damped)

%   Display the purpose of the program to the user
fprintf('Simulation of mass-spring-damper system.\n')
fprintf('This program solves several trials, simulating mass-spring-damper system.\n')
fprintf('-------------------------------------------------------------------------\n')
fprintf('Trials 1-8 generate 6 position vs. time plots in total for various conditions:\n')
fprintf('One homogeneous solution and one inhomogeneous solution for each of Runge-Kutta methods (first, second, and fourth-order)\n')
fprintf('using x0 = 1 m as initial position, v0 = 0 as initial velocity, and a0 = 2.5 N as initial force.\n')
fprintf('In addition to position vs. time plots, trials 6-8 generate video simulations to demonstrate over-damped, crtically-damped, and\nunder-damped vibrations, respectively\n')
fprintf('Option 9 generates Bode plots for all trials 1-8\n')
fprintf('-------------------------------------------------------------------------\n')

%   Display the menu of trials to the user
DisplayMenu()

%   Accept user's choice
trial = input('Enter your choice (Enter ''q'' with quation marks to quit): ');
fprintf('\n') % Skip a line

%   While trial is not 'q' for quitting
while trial ~= 'q' && trial ~= 'Q'
%=====================================================================
    %   If trial is integer in [1,8]
    if mod(trial,1)<1e-14 && trial >= 1 && trial <= 8

        %   If trial is 6
        if trial == 6
            %   Change a0
            a0 = 5;
        %   Else if trial is 7
        elseif trial == 7
            a0 = 7;
        elseif trial == 8
            a0 = 10;
        end % End a0 change

        %   Call PlotTrial using trial to to plot position vs. time
        PlotTrial(trialsMtrx,trial,dt,x0,t,a0)
        
        %   If input is in [6,8]
        if trial >= 6 && trial <= 8

            %   Get trial's mass, spring constant, and damping constant
            m = trialsMtrx(trial,1);
            k = trialsMtrx(trial,2);
            c = trialsMtrx(trial,3);

            %   Get homogeneous position vector using fourth-order aprx
            xH = SolveResponseX(x0,m,k,c,dt,4,a0,t,0);
            %   Get inhomogeneous position vector using fourth-order aprx
            xI = SolveResponseX(x0,m,k,c,dt,4,a0,t,1);

            %   If trial is 6
            if trial == 6
                %   Create video name for over-damped
                videoName = "Over-damped_Mass-spring-damper_Video";
            %   Else if trial is 7
            elseif trial == 7
                %   Create video name for critically-damped
                videoName = "Critically-damped_Mass-spring-damper_Video";
            %   Else it is 8
            else
                %   Create video name for under-damped
                videoName = "Under-damped_Mass-spring-damper_Video";
            end % End if statement for naming

            %   Create video using xH and xI
            CreateVideo(xH,xI,t,fps,videoName,trial)

        end % End video creation for trials 6-8
        
%=====================================================================
    %   Else if trial is 9
    elseif trial == 9
        %   Plot bode plots
        PlotBodePlts(trialsMtrx)
%=====================================================================
    %   Else if input is not 'q', it is invalid
    elseif trial ~= 'q' && trial ~= 'Q'
        fprintf('Invalid input, try again\n\n')
%=====================================================================

    end % End if statements for input

%   Display the menu of trials to the user
DisplayMenu()

%   Accept user's choice
trial = input('Enter your choice (Enter ''q'' with quation marks to quit): ');
fprintf('\n') % Skip a line

end % End while loop, user chose to quit

fprintf('Goodbye!\n')