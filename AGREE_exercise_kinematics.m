%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        AGREE TEST KINEMATICS                            %
%-------------------------------------------------------------------------%
% Author: Stefano Dalla Gasperina                                         %
% Email: stefano.dallagasperina@polimi.it                                 %
% Last revision: Mar-20-2020                                              %
% Description: This script builds AGREE model for both Right and Left     %
% Side graphically comparing the configuration and computing the trans-   %
% formation matrix for both right and left hands. Inverse Dynamics is     %
% then used to compute gravity torques for both right and left side.      %
% As expected they only differ by a sign.                                 %
% Instructions: Select if you want to generate or load a trajectory       %
%               Press play and, if the dialog box appears, choose a       %
%                a .mat file to load the data.                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Kinematic Model for AGREE Right and Left Side
%
% This script builds AGREE model for both Right and Left
% Side graphically comparing the configuration and computing the trans-
% formation matrix for both right and left hands.
%
% Author: Stefano Dalla Gasperina
% email: stefano.dallagasperina@polimi.it
% Last revision: Mar-20-2020

%% Begin Code

close all
clear all

%Adding functions written for this simulation

global Robot

%% Color uisetcolor

lb =    [   0.0745    0.6235    1.0000  ];
o =     [   1.0000    0.4118    0.1608  ];
dg =    [   0.3922    0.8314    0.0745  ];
v =     [   0.7176    0.2745    1.0000  ];
dr =    [   0.6353    0.0784    0.1843  ];
dy =    [   0.9294    0.6941    0.1255  ];
r =     [   1         0         0       ];
gr =    [   0.6510    0.6510    0.6510  ];

%% Start and stop
load('agree_esmacat_exercise.mat');

figure();

plot(agree_esmacat.J_elapsed_time_ms,agree_esmacat.J_command);
hold on;
plot(agree_esmacat.J_elapsed_time_ms,agree_esmacat.J_1_position_rad);
[t_start,~] = ginput(1);
t_start = round(t_start);
[t_end,~] = ginput(1);
t_end = round(t_end);

%% Build Models

% Reads parameters for R side and builds the model
% Be sure to read correct side before building the model
read_agree_parameters('right');
[Agree_Right_RST]     = build_agree_mdh();                                  % Modified DH Parameters for Right Side
[Agree_Right_RNE]     = build_agree_mdh_manual();                           % Legacy Modified DH Parameters
Agree_Right_Offsets = homeConfiguration(Agree_Right_RST);

% Reads parameters for L side and builds the model
read_agree_parameters('left');
[Agree_Left_RST]      = build_agree_mdh();                                  % Modified DH Parameters for Left Side
[Agree_Left_RNE]      = build_agree_mdh_manual();                           % Legacy Modified DH Parameters
Agree_Left_Offsets  = homeConfiguration(Agree_Left_RST);

%% Show AGREE R and L side by selecting encoder angles

%  q read by encoder.
q       =   [  0   0   0   0   0     ];      % Position [deg]
qdot    =   [   0   0   0   0   0   ];           % Velocity
qddot   =   [   0   0   0   0   0   ];           % Acceleration

q_rad = deg2rad(q);

iter=0;
X = [];
X_des = [];
Y = [];
Y_des = [];
Z = [];
Z_des = [];
perc = 0;
for t=t_start:t_end
iter=iter+1;
%Make sure you used correct active signs and offsets
q       =   [  agree_esmacat.J_0_position_rad(t) ...
               agree_esmacat.J_1_position_rad(t) ...
               agree_esmacat.J_2_position_rad(t) ...
               agree_esmacat.J_3_position_rad(t) ...
               0 ...
    ];

q_des       =   [   agree_esmacat.I_0_position_des_rad(t) ...
                    agree_esmacat.I_1_position_des_rad(t) ...
                    agree_esmacat.I_2_position_des_rad(t) ...
                    agree_esmacat.I_3_position_des_rad(t) ...
                    0 ...
    ];
T          = getTransform(Agree_Right_RST,Robot.signs_right_active.*q + Robot.offsets_right_active,'EE');
T_des          = getTransform(Agree_Right_RST,Robot.signs_right_active.*q_des + Robot.offsets_right_active,'EE');

X(end+1) = T(1,4);
X_des(end+1) = T_des(1,4);

Y(end+1) = T(2,4);
Y_des(end+1) = T_des(2,4);

Z(end+1) = T(3,4);
Z_des(end+1) = T_des(3,4);
if mod(iter,100)==0
perc = (t-t_start)/(t_end-t_start)*100;
disp(perc);
% pause;

end
end
%%

figure();
show(Agree_Right_RST, Robot.signs_right_active.*q+Robot.offsets_right_active);

figure();
time = 0:0.001:(t_end-t_start)/1000;
duration = 60; %seconds

subplot(3,1,1);

    hold on
    
    plot(time,X,'Color','k','LineWidth',1)
    plot(time,X_des,'Color',gr,'LineWidth',1);
    xlabel('Time [s]','Interpreter','LaTex')
    xlim([0 duration]);
    ylabel('Position [m]','Interpreter','LaTex')
    ylim([-0.2 0.3]);
    title('Lateral Hand Position','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';

    subplot(3,1,2);

    hold on
    
    plot(time,Y,'Color','k','LineWidth',1)
    plot(time,Y_des,'Color',gr,'LineWidth',1);
    xlabel('Time [s]','Interpreter','LaTex')
    xlim([0 duration]);
    ylabel('Position [m]','Interpreter','LaTex')
    ylim([0 0.5]);
    title('Frontal Hand Position','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    
    subplot(3,1,3);

    hold on
    
    plot(time,Z,'Color','k','LineWidth',1)
    plot(time,Z_des,'Color',gr,'LineWidth',1);
    xlabel('Time [s]','Interpreter','LaTex')
    xlim([0 duration]);
    ylabel('Position [m]','Interpreter','LaTex')
    ylim([0.5 1]);
    title('Vertical Hand Position','Interpreter','LaTex')
        legend('Desired Position','Measured Position','Interpreter','LaTeX');

    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
