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

%% Transparency Areas

    fc = 2;
    fs = 1000;
    [b,a] = butter(6,fc/(fs/2));
    agree_esmacat.J_0_position_rad_filt = filtfilt(b,a,agree_esmacat.J_0_position_rad);
    agree_esmacat.J_1_position_rad_filt = filtfilt(b,a,agree_esmacat.J_1_position_rad);
    agree_esmacat.J_2_position_rad_filt = filtfilt(b,a,agree_esmacat.J_2_position_rad);
    agree_esmacat.J_3_position_rad_filt = filtfilt(b,a,agree_esmacat.J_3_position_rad);
    
figure();
    time_4 = 0:0.001:(t_end-t_start)/1000;
subplot(2,1,1);
plot(time_4,agree_esmacat.J_0_position_rad_filt(t_start:t_end));
hold on
plot(time_4,agree_esmacat.J_1_position_rad_filt(t_start:t_end));
plot(time_4,agree_esmacat.J_2_position_rad_filt(t_start:t_end));
plot(time_4,agree_esmacat.J_3_position_rad_filt(t_start:t_end));

t = ginput(10);
close();
%% Transparency Mode Plots

duration = 40; %seconds
    
figure();
subplot(2,2,1);

    hold on
    
    yyaxis right
%     plot(time_4,agree_esmacat.J_0_velocity_rad_s(t_start:t_end),'Color',o,'LineWidth',1);
%     ylabel('Velocity [rad/s]','Interpreter','LaTex')
    % Torque loadcell
    plot(time_4,(agree_esmacat.T_0_torque_loadcell(t_start:t_end))./1000,'Color',o,'LineWidth',1);
    hold on
    % Torque desired
%     plot(time_4,agree_esmacat.T_0_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-2.5 2.5]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
    
    rectangle('Position',[round(t(1)) -10 round(t(2))-round(t(1)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(3)) -10 round(t(4))-round(t(3)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(5)) -10 round(t(6))-round(t(5)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(7)) -10 round(t(8))-round(t(7)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(9)) -10 round(t(10))-round(t(9)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     
%     rectangle('Position',[round(t(1)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(3)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(5)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(7)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(9)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])

    yyaxis left
    plot(time_4,agree_esmacat.J_0_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    hold on
    plot(time_4,agree_esmacat.I_0_position_des_rad(t_start:t_end),'Color',gr,'LineWidth',1);

    ylim([-1 1]);
    xlim([0 duration])
    ylabel('Position [rad]','Interpreter','LaTex')
    hold off
    
    xlabel('Time [s]','Interpreter','LaTex')
    title('J1 - Shoulder adduction/abduction','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
subplot(2,2,2);
    hold on
    
    yyaxis right
    % Torque loadcell
    plot(time_4,-(agree_esmacat.T_1_torque_loadcell(t_start:t_end))./1000,'Color',o,'LineWidth',1);
    hold on
    % Torque desired
%     plot(time_4,-agree_esmacat.T_1_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-7.5 7.5]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
    
    rectangle('Position',[round(t(1)) -10 round(t(2))-round(t(1)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(3)) -10 round(t(4))-round(t(3)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(5)) -10 round(t(6))-round(t(5)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(7)) -10 round(t(8))-round(t(7)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(9)) -10 round(t(10))-round(t(9)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])

%     rectangle('Position',[round(t(1)) -10 4 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(3)) -10 4 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(5)) -10 4 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(7)) -10 4 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(9)) -10 4 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%         
    yyaxis left
    plot(time_4,-agree_esmacat.J_1_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    hold on
    plot(time_4,-agree_esmacat.I_1_position_des_rad(t_start:t_end),'Color',gr,'LineWidth',1);

    hold off
    title('J2 - Shoulder flextion/extension','Interpreter','LaTex')
    ylabel('Position [rad]','Interpreter','LaTex')
    ylim([0 2]);
    xlim([0 duration])
    xlabel('Time [s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;
         legend('Measured Position','Desired Position','Measured Torque','Interpreter','LaTeX','Location','South');

%%%%%%%%%%%%%%%

subplot(2,2,3);
    hold on

    yyaxis right
    % Torque loadcell
    plot(time_4,(agree_esmacat.T_2_torque_loadcell(t_start:t_end))./1000,'Color',o,'LineWidth',1);
    hold on
    % Torque desired
%     plot(time_4,agree_esmacat.T_2_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-2.5 2.5]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
    
    rectangle('Position',[round(t(1)) -10 round(t(2))-round(t(1)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(3)) -10 round(t(4))-round(t(3)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(5)) -10 round(t(6))-round(t(5)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(7)) -10 round(t(8))-round(t(7)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(9)) -10 round(t(10))-round(t(9)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     
%     rectangle('Position',[round(t(1)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(3)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(5)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(7)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(9)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%         
    yyaxis left
    plot(time_4,agree_esmacat.J_2_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    hold on
    plot(time_4,agree_esmacat.I_2_position_des_rad(t_start:t_end),'Color',gr,'LineWidth',1);

    hold off
    title('J3 - Humeral rotation','Interpreter','LaTex')
    ylim([-1.5 0.5]);
    xlim([0 duration])
    ylabel('Position [rad]','Interpreter','LaTex')
    xlabel('Time [s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;
    
    %%%%%%%%%%%%%%%

   subplot(2,2,4);
       hold on
    yyaxis right
    % Torque loadcell
    plot(time_4,(agree_esmacat.T_3_torque_loadcell(t_start:t_end))./1000,'Color',o,'LineWidth',1);
    hold on
    % Torque desired
%     plot(time_4,agree_esmacat.T_3_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-5 5]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
   
        
    rectangle('Position',[round(t(1)) -10 round(t(2))-round(t(1)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(3)) -10 round(t(4))-round(t(3)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(5)) -10 round(t(6))-round(t(5)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(7)) -10 round(t(8))-round(t(7)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
    rectangle('Position',[round(t(9)) -10 round(t(10))-round(t(9)) 20],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     
%         rectangle('Position',[round(t(1)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(3)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(5)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(7)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     rectangle('Position',[round(t(9)) -5 4 10],'FaceColor',[0.6510    0.6510    0.6510 0.2],'EdgeColor',[  0   0   0   0.2])
%     
    yyaxis left
    plot(time_4,agree_esmacat.J_3_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    hold on
    plot(time_4,agree_esmacat.I_3_position_des_rad(t_start:t_end),'Color',gr,'LineWidth',1);

    hold off
    ylim([0	 2]);
    xlim([0 duration])

     title('J4 - Elbow flexion/extension','Interpreter','LaTex')

    ylabel('Position [rad]','Interpreter','LaTex')
    xlabel('Time [s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;


