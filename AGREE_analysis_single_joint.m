close all
clear all
clc

%% Color uisetcolor

lb =    [   0.0745    0.6235    1.0000  ];
o =     [   1.0000    0.4118    0.1608  ];
dg =    [   0.3922    0.8314    0.0745  ];
v =     [   0.7176    0.2745    1.0000  ];
dr =    [   0.6353    0.0784    0.1843  ];
dy =    [   0.9294    0.6941    0.1255  ];
r =     [   1         0         0       ];
gr =    [   0.6510    0.6510    0.6510  ];

%% Import data
load('data/agree_esmacat_J1.mat');

figure();

plot(agree_esmacat.J_elapsed_time_ms./1000,agree_esmacat.J_command);
hold on
plot(agree_esmacat.J_elapsed_time_ms./1000,agree_esmacat.J_status);

ylabel('Esmacat Command','Interpreter','LaTex')
hold off
xlabel('Time [s]','Interpreter','LaTex')
axesH = gca;
axesH.FontSize=14;
axesH.FontWeight='bold';
axesH.TickLabelInterpreter='LaTex';
axesH.YAxis(1).Color = 'k';

%% Start and stop manual selection
% [t_start,~] = ginput(1);
% t_start = round(t_start);
% [t_end,~] = ginput(1);
% t_end = round(t_end);

%% Stiffness/damping analysis

% Select stiffness values to be analyzed
stiffness = [5000 10000 15000 20000];
damping   = [2000 4500];

figure();
plot(agree_esmacat.J_elapsed_time_ms,agree_esmacat.I_0_stiffness);
hold on;
plot(agree_esmacat.J_elapsed_time_ms,agree_esmacat.I_0_damping);

%%
% For each stiffness level
for k=1:length(stiffness)
    for d = 1:length(damping)
        
        % find time indexes for each stiffness/damping combination
        time_index = find(agree_esmacat.I_0_stiffness == stiffness(k) & agree_esmacat.I_0_damping==damping(d) & agree_esmacat.J_command==107);
        
        % if stiffness/damping combination is found, plot it
        if not(isempty(time_index))
            
            time = 0:0.001:(time_index(end)-time_index(1))/1000;
            
            figure();
            plot(time,agree_esmacat.J_0_position_rad(time_index));
            hold on
            plot(time,agree_esmacat.I_0_position_des_rad(time_index));
            
            title(sprintf('J1 joint: Ks = %.2f Kd = %.2f', stiffness(k)./1000,damping(d)./1000),'Interpreter','LaTex')
            ylabel('Position [rad]','Interpreter','LaTex')
            hold off
            xlabel('Time [s]','Interpreter','LaTex')
            axesH = gca;
            axesH.FontSize=14;
            axesH.FontWeight='bold';
            axesH.TickLabelInterpreter='LaTex';
            axesH.YAxis(1).Color = 'k';
        % if not, display warning
        else
            fprintf('J1 joint: Ks = %.2f Kd = %.2f not found\n', stiffness(k)./1000,damping(d)./1000);
        end
    end
end

%% Next steps ...

