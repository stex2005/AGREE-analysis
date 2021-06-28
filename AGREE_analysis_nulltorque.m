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
load('agree_esmacat_nulltorque.mat');

figure();
plot(agree_esmacat.J_elapsed_time_ms,agree_esmacat.J_command);
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

%% Transparency Mode Plots

%     t_start = find(agree_esmacat.J_status==4,1,'first')+delta;
%     t_end= find(agree_esmacat.J_status==4,1,'last');

    
figure();
subplot(2,2,1);

    hold on
    
    yyaxis right
%     plot(time_4,agree_esmacat.J_0_velocity_rad_s(t_start:t_end),'Color',o,'LineWidth',1);
%     ylabel('Velocity [rad/s]','Interpreter','LaTex')
    % Torque loadcell
    plot(time_4,(agree_esmacat.T_0_torque_loadcell(t_start:t_end))./1000-0.1,'Color',o,'LineWidth',1);
    hold on
    % Torque desired
    plot(time_4,agree_esmacat.T_0_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-2 2]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
   
    yyaxis left
    plot(time_4,agree_esmacat.J_0_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    ylim([-1 1]);
    ylabel('Position [rad]','Interpreter','LaTex')
    hold off
    
    xlabel('Time [s]','Interpreter','LaTex')
        xlim([0 20])

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
    plot(time_4,-agree_esmacat.T_1_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-2 2]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
        
    yyaxis left
    plot(time_4,-agree_esmacat.J_1_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    hold off
    title('J2 - Shoulder flextion/extension','Interpreter','LaTex')
    ylabel('Position [rad]','Interpreter','LaTex')
    ylim([0 2]);

    xlabel('Time [s]','Interpreter','LaTex')
        xlim([0 20])

    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;
%     legend('Residual torque','Measured torque','Desired torque','Interpreter','LaTex');

%%%%%%%%%%%%%%%

subplot(2,2,3);
    hold on

    yyaxis right
    % Torque loadcell
    plot(time_4,(agree_esmacat.T_2_torque_loadcell(t_start:t_end))./1000,'Color',o,'LineWidth',1);
    hold on
    % Torque desired
    plot(time_4,agree_esmacat.T_2_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-2 2]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
            
    yyaxis left
    plot(time_4,agree_esmacat.J_2_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    hold off
    title('J3 - Humeral rotation','Interpreter','LaTex')
    ylim([-1.5 0.5]);
    ylabel('Position [rad]','Interpreter','LaTex')
    xlabel('Time [s]','Interpreter','LaTex')
        xlim([0 20])

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
    plot(time_4,agree_esmacat.T_3_torque_des(t_start:t_end)./1000,'Color',gr,'LineWidth',1);
    ylim([-2 2]);
    ylabel('Torque [Nm]','Interpreter','LaTex')
    
    yyaxis left
    plot(time_4,agree_esmacat.J_3_position_rad_filt(t_start:t_end),'k','LineWidth',1);
    hold off
        ylim([0 2]);

     title('J4 - Elbow flexion/extension','Interpreter','LaTex')
         legend('Measured Position','Measured Torque','Null Torque','Interpreter','LaTeX','Location','South');

    ylabel('Position [rad]','Interpreter','LaTex')
    xlabel('Time [s]','Interpreter','LaTex')
        xlim([0 20])

    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;




%% Transparency Mode Plots

%     t_start = find(agree_esmacat.J_status==4,1,'first')+delta;
%     t_end= find(agree_esmacat.J_status==4,1,'last');
    time_4 = 0:0.001:(t_end-t_start)/1000;

    fc = 15;
    fs = 1000;
    [b,a] = butter(12,fc/(fs/2));
    agree_esmacat.T_0_torque_loadcell_filt = filtfilt(b,a,agree_esmacat.T_0_torque_loadcell);
    agree_esmacat.T_1_torque_loadcell_filt = filtfilt(b,a,agree_esmacat.T_1_torque_loadcell);
    agree_esmacat.T_2_torque_loadcell_filt = filtfilt(b,a,agree_esmacat.T_2_torque_loadcell);
    agree_esmacat.T_3_torque_loadcell_filt = filtfilt(b,a,agree_esmacat.T_3_torque_loadcell);


    
figure();
subplot(2,2,1);

    hold on
    
    yyaxis right
    plot(time_4,agree_esmacat.J_0_velocity_rad_s(t_start:t_end),'Color',o,'LineWidth',1);
    ylabel('Velocity [rad/s]','Interpreter','LaTex')
        
    yyaxis left
    plot(time_4,agree_esmacat.J_0_position_rad(t_start:t_end),'k','LineWidth',1);
    ylabel('Position [rad]','Interpreter','LaTex')

    hold off
    
    xlabel('Time [ms]','Interpreter','LaTex')
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
    plot(time_4,agree_esmacat.J_1_velocity_rad_s(t_start:t_end),'Color',o,'LineWidth',1);
    ylabel('Velocity [rad/s]','Interpreter','LaTex')
        
    yyaxis left
    plot(time_4,agree_esmacat.J_1_position_rad(t_start:t_end),'k','LineWidth',1);
    hold off
    title('J2 - Shoulder flextion/extension','Interpreter','LaTex')
    ylabel('Position [rad]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;
%     legend('Residual torque','Measured torque','Desired torque','Interpreter','LaTex');

%%%%%%%%%%%%%%%

   subplot(2,2,3);
       hold on
    yyaxis right
    plot(time_4,agree_esmacat.J_2_velocity_rad_s(t_start:t_end),'Color',o,'LineWidth',1);
    ylabel('Velocity [rad/s]','Interpreter','LaTex')
        
    yyaxis left
    plot(time_4,agree_esmacat.J_2_position_rad(t_start:t_end),'k','LineWidth',1);
    hold off
    title('J3 - Humeral rotation','Interpreter','LaTex')
    ylabel('Position [rad]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
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
    plot(time_4,agree_esmacat.J_3_velocity_rad_s(t_start:t_end),'Color',o,'LineWidth',1);
    ylabel('Velocity [rad/s]','Interpreter','LaTex')
        
    yyaxis left
    plot(time_4,agree_esmacat.J_3_position_rad(t_start:t_end),'k','LineWidth',1);
    hold off
     title('J4 - Elbow flexion/extension','Interpreter','LaTex')
    ylabel('Position [rad]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
    axesH.YAxis(2).Color = o;

figure();

% subplot(2,2,3);
% Torque filtered 20Hz
% plot(time,esmacat_log_transparency.T_0_torque_loadcell_filt(t_start:t_end)-esmacat_log_transparency.T_0_torque_grav(t_start:t_end),'LineWidth',1);
subplot(2,2,1);
    % Torque desired
%     plot(time_4,(-agree_esmacat.T_0_torque_des(t_start:t_end)+agree_esmacat.T_0_torque_loadcell_filt(t_start:t_end))./1000,'Color',gr,'LineWidth',2);
%     hold on
    % Torque filtered 20 Hz
    plot(time_4,(agree_esmacat.T_0_torque_loadcell_filt(t_start:t_end)-mean(agree_esmacat.T_0_torque_loadcell_filt(t_start:t_end)))./1000,'b','LineWidth',1);
    hold on
    % Torque desired
    plot(time_4,agree_esmacat.T_0_torque_des(t_start:t_end)./1000,'r','LineWidth',1);
    
    ylabel('Torque [Nm]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
%         legend('Residual torque','Measured torque','Gravity torque','Interpreter','LaTex','Location','SouthEast');
    ylim([-0.5 0.5])
    xlim([0 20])
    
subplot(2,2,2);
    % Torque desired
%     plot(time_4,(-agree_esmacat.T_1_torque_des(t_start:t_end)+agree_esmacat.T_1_torque_loadcell_filt(t_start:t_end))./1000,'Color',gr,'LineWidth',2);
    % Torque filtered 20 Hz
    plot(time_4,(agree_esmacat.T_1_torque_loadcell_filt(t_start:t_end)-mean(agree_esmacat.T_1_torque_loadcell_filt(t_start:t_end)))./1000,'b','LineWidth',1);
        hold on

    % Torque desired
    plot(time_4,agree_esmacat.T_1_torque_des(t_start:t_end)./1000,'r','LineWidth',1);
    
    ylabel('Torque [Nm]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
%         legend('Residual torque','Measured torque','Gravity torque','Interpreter','LaTex','Location','SouthEast');
    ylim([-0.5 0.5])
    xlim([0 20])
    
subplot(2,2,3);
    % Torque filtered 20 Hz
    plot(time_4,(agree_esmacat.T_2_torque_loadcell_filt(t_start:t_end)-mean(agree_esmacat.T_2_torque_loadcell_filt(t_start:t_end)))./1000,'b','LineWidth',1);
    hold on
    % Torque desired
    plot(time_4,agree_esmacat.T_2_torque_des(t_start:t_end)./1000,'r','LineWidth',1);
    
    ylabel('Torque [Nm]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
%         legend('Residual torque','Measured torque','Gravity torque','Interpreter','LaTex','Location','SouthEast');
    ylim([-0.5 0.5])
    xlim([0 20])
    
subplot(2,2,4);

    % Torque filtered 20 Hz
    plot(time_4,(agree_esmacat.T_3_torque_loadcell_filt(t_start:t_end)-mean(agree_esmacat.T_3_torque_loadcell_filt(t_start:t_end)))./1000,'b','LineWidth',1);
    hold on
    % Torque desired
    plot(time_4,agree_esmacat.T_3_torque_des(t_start:t_end)./1000,'r','LineWidth',1);
    
    ylabel('Torque [Nm]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
%         legend('Residual torque','Measured torque','Gravity torque','Interpreter','LaTex','Location','SouthEast');
    ylim([-0.5 0.5])
    xlim([0 20])
%     max_residual_freemotion = max(-agree_esmacat.T_0_torque_des(t_start:t_end)+agree_esmacat.T_0_torque_loadcell_filt(t_start:t_end));
%     min_residual_freemotion = min(-agree_esmacat.T_0_torque_des(t_start:t_end)+agree_esmacat.T_0_torque_loadcell_filt(t_start:t_end));

    % Torque filtered in esmacat software
    % plot(time,esmacat_log_transparency.T_0_torque_loadcell_filtered(t_start:t_end)-esmacat_log_transparency.T_0_torque_grav(t_start:t_end));





    hold off

 %{
%% Transparency Plot - Beta function
load('esmacat_log_transparency.mat');


% Status 104 or 5
    delta = 7500;
    t_start = find(esmacat_log_transparency.J_status==104,1,'first')+delta;
    t_end= find(esmacat_log_transparency.J_status==104,1,'last');
    time_4 = 0:0.001:(t_end-t_start)/1000;

    fc = 20;
    fs = 1000;
    [b,a] = butter(12,fc/(fs/2));
    esmacat_log_transparency.T_0_torque_loadcell_filt = filtfilt(b,a,esmacat_log_transparency.T_0_torque_loadcell);
    
    v1 = -esmacat_log_transparency.J_0_velocity_rad_s(t_start:t_end);
    p1 = -esmacat_log_transparency.J_0_position_rad(t_start:t_end);

figure();
% subplot(2,2,2);
subplot(2,1,1);
    hold on
    
        
    yyaxis left
    plot(time_4,-esmacat_log_transparency.J_0_position_rad(t_start:t_end),'k','LineWidth',1);
    ylabel('Position [rad]','Interpreter','LaTex')    
    
    yyaxis right
    plot(time_4,-esmacat_log_transparency.J_0_velocity_rad_s(t_start:t_end),'Color',o,'LineWidth',1);
    ylabel('Velocity [rad/s]','Interpreter','LaTex')

%     title('Transparency - Trajectory Tracking','Interpreter','LaTex')

    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    axesH.YAxis(1).Color = 'k';
     axesH.YAxis(2).Color = o;
%     xlim([0 30])
%     legend('Residual torque','Measured torque','Desired torque','Interpreter','LaTex');

% subplot(2,2,4);
subplot(2,1,2);

    % Torque filtered 20Hz
%     plot(time,esmacat_log_transparency.T_0_torque_loadcell_filt(t_start:t_end)-esmacat_log_transparency.T_0_torque_grav(t_start:t_end),'LineWidth',1);

    % Torque desired
    plot(time_4,(-esmacat_log_transparency.T_0_torque_des(t_start:t_end)+esmacat_log_transparency.T_0_torque_loadcell_filt(t_start:t_end))./1000,'Color',gr,'LineWidth',2);
    hold on
    
    max_residual_betafunction = max(-esmacat_log_transparency.T_0_torque_des(t_start:t_end)+esmacat_log_transparency.T_0_torque_loadcell_filt(t_start:t_end));
    min_residual_betafunction = min(-esmacat_log_transparency.T_0_torque_des(t_start:t_end)+esmacat_log_transparency.T_0_torque_loadcell_filt(t_start:t_end));


    % Torque filtered in esmacat software
    % plot(time,esmacat_log_transparency.T_0_torque_loadcell_filtered(t_start:t_end)-esmacat_log_transparency.T_0_torque_grav(t_start:t_end));

    % Torque filtered 20 Hz
    plot(time_4,esmacat_log_transparency.T_0_torque_loadcell_filt(t_start:t_end)./1000,'b','LineWidth',1);
    % Torque desired
    plot(time_4,esmacat_log_transparency.T_0_torque_des(t_start:t_end)./1000,'Color',r,'LineWidth',1);

%     title('Dynamics - Torque','Interpreter','LaTex')
    ylabel('Torque [Nm]','Interpreter','LaTex')
    xlabel('Time [ms]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.TickLabelInterpreter='LaTex';
        axesH.FontWeight='bold';
    legend('Residual torque','Measured torque','Commanded torque','Interpreter','LaTex','Location','NorthEast');
    ylim([-1 1])
%     xlim([0 30])

    hold off
    
%% Transparency - Residual Friction

figure();
% t_end = t_start+10000;
t_line = t_start:25:t_end;
offset = 0;0.0323;
xData = -esmacat_log_transparency.J_0_velocity_rad_s(t_line);
yData = (-esmacat_log_transparency.T_0_torque_des(t_line)+esmacat_log_transparency.T_0_torque_loadcell_filt(t_line))./1000-offset;

% Set up fittype and options.
ft = fittype( 'poly1' );
% Fit model to data.
f = fit( xData, yData, ft );

plot(xData,yData,'.');
hold on;
plot(f);
    title('Transparency - Residual Friction','Interpreter','LaTex')
    ylabel('Torque [Nm]','Interpreter','LaTex')
    xlabel('Velocity [rad/s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=10;
    axesH.TickLabelInterpreter='LaTex';
legend('Experimental','Fitted Curve 0.150 Nm/(rad/s)','Location','NorthWest');
    
    
%% Stiffness Validation

load('esmacat_log_stiffness2.mat');
figure();
subplot(2,1,1);
t_start=1;
t_end= 10000;t_start+4*8000;
hold off
plot(esmacat_log_stiffness.T_0_torque_loadcell_filtered(t_start:t_end)-esmacat_log_stiffness.T_0_torque_grav(t_start:t_end));
hold on
% plot(esmacat_log_transparency.T_0_torque_loadcell(t_start:t_end)-esmacat_log_transparency.T_0_torque_grav(t_start:t_end));
plot(esmacat_log_stiffness.T_0_torque_loadcell(t_start:t_end));
plot(esmacat_log_stiffness.T_0_torque_des(t_start:t_end));
subplot(2,1,2);
plot(esmacat_log_stiffness.I_0_stiffness);

t_40 = find(esmacat_log_stiffness.I_0_stiffness==40000);
t_20 = find(esmacat_log_stiffness.I_0_stiffness==20000);
t_10 = find(esmacat_log_stiffness.I_0_stiffness==10000);
t_5 = find(esmacat_log_stiffness.I_0_stiffness==5000);

figure();
subplot(2,2,1);
    t_start = find(esmacat_log_stiffness.I_0_stiffness==40000,1,'first');
    t_end= find(esmacat_log_stiffness.I_0_stiffness==40000,1,'last');
    t_40 = t_start:50:t_end;
    
    plot(-esmacat_log_stiffness.J_0_position_rad(t_40),(esmacat_log_stiffness.T_0_torque_loadcell(t_40)+esmacat_log_stiffness.J_0_velocity_rad_s(t_40).*esmacat_log_stiffness.I_0_damping(t_40))./1000,'.');
    xlim([-0.75 0.75])
    ylim([-10 10])
    title('Stiffness 40 Nm/rad','Interpreter','LaTex')
    ylabel('$Torque$ [Nm]','Interpreter','LaTex')
%     xlabel('$Position Error$ [rad]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=10;
    axesH.TickLabelInterpreter='LaTex';
subplot(2,2,2);
    t_start = find(esmacat_log_stiffness.I_0_stiffness==20000,1,'first');
    t_end= find(esmacat_log_stiffness.I_0_stiffness==20000,1,'last');
    t_20 = t_start:50:t_end;
    plot(-esmacat_log_stiffness.J_0_position_rad(t_20),(esmacat_log_stiffness.T_0_torque_loadcell(t_20)+esmacat_log_stiffness.J_0_velocity_rad_s(t_20).*esmacat_log_stiffness.I_0_damping(t_20))./1000);
    xlim([-0.75 0.75])
    ylim([-10 10])
    title('Stiffness 20 Nm/rad','Interpreter','LaTex')
    ylabel('$Torque$ [Nm]','Interpreter','LaTex')
%     xlabel('$Position Error$ [rad]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=10;
    axesH.TickLabelInterpreter='LaTex';
subplot(2,2,3);
    t_start = find(esmacat_log_stiffness.I_0_stiffness==10000,1,'first');
    t_end= find(esmacat_log_stiffness.I_0_stiffness==10000,1,'last');
    t_10 = t_start:50:t_end;
    plot(-esmacat_log_stiffness.J_0_position_rad(t_10),(esmacat_log_stiffness.T_0_torque_loadcell(t_10)+esmacat_log_stiffness.J_0_velocity_rad_s(t_10).*esmacat_log_stiffness.I_0_damping(t_10))./1000);
    xlim([-0.75 0.75])
    ylim([-10 10])
    title('Stiffness 10 Nm/rad','Interpreter','LaTex')
    ylabel('$Torque$ [Nm]','Interpreter','LaTex')
    xlabel('$Position$ [rad]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=10;
    axesH.TickLabelInterpreter='LaTex';
subplot(2,2,4);
    t_start = find(esmacat_log_stiffness.I_0_stiffness==5000,1,'first');
    t_end= find(esmacat_log_stiffness.I_0_stiffness==5000,1,'last');
    t_5 = t_start:50:t_end;
    plot(-esmacat_log_stiffness.J_0_position_rad(t_5),(esmacat_log_stiffness.T_0_torque_loadcell(t_5)+esmacat_log_stiffness.J_0_velocity_rad_s(t_5).*esmacat_log_stiffness.I_0_damping(t_5))./1000);
    xlim([-0.75 0.75])
    ylim([-10 10])
    title('Stiffness 5 Nm/rad','Interpreter','LaTex')
    ylabel('$Torque$ [Nm]','Interpreter','LaTex')
    xlabel('$Position$ [rad]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=10;
    axesH.TickLabelInterpreter='LaTex';

%%
figure();
    plot(-esmacat_log_stiffness.J_0_position_rad(t_40),(esmacat_log_stiffness.T_0_torque_loadcell(t_40)-esmacat_log_stiffness.T_0_torque_grav(t_40)+esmacat_log_stiffness.J_0_velocity_rad_s(t_40).*esmacat_log_stiffness.I_0_damping(t_40))./1000,'.','Color',lb);
    hold on
    plot(-esmacat_log_stiffness.J_0_position_rad(t_20),(esmacat_log_stiffness.T_0_torque_loadcell(t_20)-esmacat_log_stiffness.T_0_torque_grav(t_20)+esmacat_log_stiffness.J_0_velocity_rad_s(t_20).*esmacat_log_stiffness.I_0_damping(t_20))./1000,'.','Color',dg);
    plot(-esmacat_log_stiffness.J_0_position_rad(t_10),(esmacat_log_stiffness.T_0_torque_loadcell(t_10)-esmacat_log_stiffness.T_0_torque_grav(t_10)+esmacat_log_stiffness.J_0_velocity_rad_s(t_10).*esmacat_log_stiffness.I_0_damping(t_10))./1000,'.','Color',v);
    plot(-esmacat_log_stiffness.J_0_position_rad(t_5),(esmacat_log_stiffness.T_0_torque_loadcell(t_5)-esmacat_log_stiffness.T_0_torque_grav(t_5)+esmacat_log_stiffness.J_0_velocity_rad_s(t_5).*esmacat_log_stiffness.I_0_damping(t_5))./1000,'.','Color',o); 
    
% Set up fittype and options.
ft = fittype( 'poly1' );    
% 40 Nm/rad  Fit model to data.
xData = -esmacat_log_stiffness.J_0_position_rad(t_40);
yData = (esmacat_log_stiffness.T_0_torque_loadcell(t_40)-esmacat_log_stiffness.T_0_torque_grav(t_40)+esmacat_log_stiffness.J_0_velocity_rad_s(t_40).*esmacat_log_stiffness.I_0_damping(t_40))./1000;
f_40 = fit( xData, yData, ft )

% 20 Nm/rad  Fit model to data.
xData = -esmacat_log_stiffness.J_0_position_rad(t_20);
yData = (esmacat_log_stiffness.T_0_torque_loadcell(t_20)-esmacat_log_stiffness.T_0_torque_grav(t_20)+esmacat_log_stiffness.J_0_velocity_rad_s(t_20).*esmacat_log_stiffness.I_0_damping(t_20))./1000;
f_20 = fit( xData, yData, ft )

% 10 Nm/rad  Fit model to data.
xData = -esmacat_log_stiffness.J_0_position_rad(t_10);
yData = (esmacat_log_stiffness.T_0_torque_loadcell(t_10)-esmacat_log_stiffness.T_0_torque_grav(t_10)+esmacat_log_stiffness.J_0_velocity_rad_s(t_10).*esmacat_log_stiffness.I_0_damping(t_10))./1000;
f_10 = fit( xData, yData, ft )

% 10 Nm/rad  Fit model to data.
xData = -esmacat_log_stiffness.J_0_position_rad(t_5);
yData = (esmacat_log_stiffness.T_0_torque_loadcell(t_5)-esmacat_log_stiffness.T_0_torque_grav(t_5)+esmacat_log_stiffness.J_0_velocity_rad_s(t_5).*esmacat_log_stiffness.I_0_damping(t_5))./1000;
f_5 = fit( xData, yData, ft )

    plot(f_40,'-k');
    plot(f_20,'-k');
    plot(f_10,'-k');    
    plot(f_5,'-k');
    xlim([-0.75 0.75])
    ylim([-10 10])
%     title('Stiffness Nm/rad','Interpreter','LaTex')
    ylabel('Torque [Nm]','Interpreter','LaTex')
    xlabel('Angle deviation from equilibrium point [rad]','Interpreter','LaTex')
    
    axesH = gca;
    axesH.FontSize=12;
    axesH.FontWeight='bold';
    axesH.TickLabelInterpreter='LaTex';
    legend(sprintf('40 (fitted %.2f) Nm/rad', f_40.p1) ,sprintf('20 (fitted %.2f) Nm/rad ', f_20.p1) ,sprintf('10 (fitted %.2f) Nm/rad', f_10.p1) ,sprintf('5 (fitted %.2f) Nm/rad', f_5.p1) ,'Interpreter','LaTex','Location','SouthEast');
    
    fidelity = [abs(40-f_40.p1)/40 abs(20-f_20.p1)/20 abs(10-f_10.p1)/10 abs(5-f_5.p1)/5]
    f_mean = (1-mean(fidelity))*100;
    f_std = std(fidelity)*100;

%% 
figure();
    plot(-esmacat_log_stiffness.J_0_position_rad(t_40),(esmacat_log_stiffness.T_0_torque_loadcell(t_40))./1000,'.');
    hold on
    plot(-esmacat_log_stiffness.J_0_position_rad(t_20),(esmacat_log_stiffness.T_0_torque_loadcell(t_20))./1000,'.');
    plot(-esmacat_log_stiffness.J_0_position_rad(t_10),(esmacat_log_stiffness.T_0_torque_loadcell(t_10))./1000,'.');
    plot(-esmacat_log_stiffness.J_0_position_rad(t_5),(esmacat_log_stiffness.T_0_torque_loadcell(t_5))./1000,'.');
    xlim([-0.75 0.75])
    ylim([-10 10])
    title('Stiffness Nm/rad','Interpreter','LaTex')
    ylabel('$Torque$ [Nm]','Interpreter','LaTex')
    xlabel('$Position$ [rad]','Interpreter','LaTex')
    
    axesH = gca;
    axesH.FontSize=10;
    axesH.TickLabelInterpreter='LaTex';
    legend('40 Nm/rad','20 Nm/rad','10 Nm/rad','5 Nm/rad','Interpreter','LaTex','Location','SouthEast');


%% Torque Fidelity
load('esmacat_log_torque.mat');

% delta = 7500;
% t_0_start = find(esmacat_log_0_5_a.J_status==104,1,'first')
% t_end= find(esmacat_log_transparency.J_status==104,1,'last');
duration = 6000;
time_4 = 0:0.001:duration/1000;

t_0_start = 11023;43821; find(esmacat_log_0_5_a.J_status);
t_0_end = t_0_start+duration;

t_1_start = 42877; find(esmacat_log_1_0.J_status);
t_1_end = t_1_start+duration;

duration = 3000;
time_2 = 0:0.001:duration/1000;


t_2_start = 42011; find(esmacat_log_2_0.J_status);
t_2_end = t_2_start+duration;

t_4_start = 26924; find(esmacat_log_4_0.J_status);
t_4_end = t_4_start+duration;

t_2 = find(esmacat_log_2_0.J_status);
t_4 = find(esmacat_log_4_0.J_status);


% t_2 = find(esmacat_log_stiffness.J_status==2,first);
% t_4 = find(esmacat_log_stiffness.J_status==2,first);
% t_1 = find(esmacat_log_stiffness.J_status==2,first);

figure();
title('Torque control fidelity');
subplot(2,2,1);
    plot(time_4,esmacat_log_0_5_c.T_0_torque_loadcell(t_0_start:t_0_end)./1000,'b','LineWidth',1.5);
    hold on
    plot(time_4,esmacat_log_0_5_c.T_0_torque_des(t_0_start:t_0_end)./1000,'r');
    title('Frequency - 0.5 Hz','Interpreter','LaTex')
    ylabel('Torque [Nm]','Interpreter','LaTex')
        ylim([ 1 7])

%     xlabel('$Time$ [s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.TickLabelInterpreter='LaTex';
    
    A = esmacat_log_0_5_c.T_0_torque_loadcell(t_0_start:t_0_end);
    B = esmacat_log_0_5_c.T_0_torque_des(t_0_start:t_0_end);
    rmse_0 = sqrt(mean((A-B).^2));
    pe_0 = sqrt(max((A-B).^2));
    R_0 = corrcoef(A,B);

subplot(2,2,2);
    plot(time_4,esmacat_log_1_0.T_0_torque_loadcell(t_1_start:t_1_end)./1000,'b','LineWidth',1.5);
    hold on
    plot(time_4,esmacat_log_1_0.T_0_torque_des(t_1_start:t_1_end)./1000,'r');
        title('Frequency - 1.0 Hz','Interpreter','LaTex')
    ylabel('Torque [Nm]','Interpreter','LaTex')
    ylim([ 1 7])
%     xlabel('$Time$ [s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.TickLabelInterpreter='LaTex';
    

    A = esmacat_log_1_0.T_0_torque_loadcell(t_1_start:t_1_end);
    B = esmacat_log_1_0.T_0_torque_des(t_1_start:t_1_end);
    rmse_1 = sqrt(mean((A-B).^2));
    pe_1 = sqrt(max((A-B).^2));
    R_1 = corrcoef(A,B);

time_4 = 0:0.001:duration/1000;
subplot(2,2,3);
    plot(time_2,esmacat_log_2_0.T_0_torque_loadcell(t_2_start:t_2_end)./1000,'b','LineWidth',1.5);
    hold on
    plot(time_2,esmacat_log_2_0.T_0_torque_des(t_2_start:t_2_end)./1000,'r');
    title('Frequency - 2.0 Hz','Interpreter','LaTex')
    ylabel('Torque [Nm]','Interpreter','LaTex')
        ylim([ 1 7])

    xlabel('Time [s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.TickLabelInterpreter='LaTex';
    
    A = esmacat_log_2_0.T_0_torque_loadcell(t_2_start:t_2_end);
    B = esmacat_log_2_0.T_0_torque_des(t_2_start:t_2_end);
    rmse_2 = sqrt(mean((A-B).^2));
    pe_2 = sqrt(max((A-B).^2));
    R_2 = corrcoef(A,B);

subplot(2,2,4);
    plot(time_2,esmacat_log_4_0.T_0_torque_loadcell(t_4_start:t_4_end)./1000,'b','LineWidth',1.5);
    hold on
    plot(time_2,esmacat_log_4_0.T_0_torque_des(t_4_start:t_4_end)./1000,'r');
    title('Frequency - 4.0 Hz','Interpreter','LaTex')

    ylabel('Torque [Nm]','Interpreter','LaTex')
        ylim([ 1 7])

    xlabel('Time [s]','Interpreter','LaTex')
    axesH = gca;
    axesH.FontSize=14;
    axesH.TickLabelInterpreter='LaTex';
    
    A = esmacat_log_4_0.T_0_torque_loadcell(t_4_start:t_4_end);
    B = esmacat_log_4_0.T_0_torque_des(t_4_start:t_4_end);
    rmse_4 = sqrt(mean((A-B).^2));
    pe_4 = sqrt(max((A-B).^2));
    R_4 = corrcoef(A,B);

%%
% % close all
% 
% load('esmacat_log_chirp.mat');
% figure();
% x = esmacat_log_chirp.T_0_torque_loadcell(15000:end)/ esmacat_log_chirp.T_0_torque_des(15000:end);
% 
% plot(x);
% hold on
% % plot(esmacat_log_chirp.T_0_torque_des);
% ylim([1000 7000]);
% 
% figure();


% %%
% rng default
% Fs = 1000;
% t = 0:1/Fs:1-1/Fs;
% x = esmacat_log_chirp.T_0_torque_des(15000:end);
% 
% % Obtain the periodogram using fft. The signal is real-valued and has even length. Because the signal is real-valued, you only need power estimates for the positive or negative frequencies. In order to conserve the total power, multiply all frequencies that occur in both sets — the positive and negative frequencies — by a factor of 2. Zero frequency (DC) and the Nyquist frequency do not occur twice. Plot the result.
% 
% N = length(x);
% xdft = fft(x);
% xdft = xdft(1:N/2+1);
% psdx = (1/(Fs*N)) * abs(xdft).^2;
% psdx(2:end-1) = 2*psdx(2:end-1);
% freq = 0:Fs/length(x):Fs/2;
% figure();
% plot(freq,10*log10(psdx))
% grid on
% hold on
% title('Periodogram Using FFT')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')
% xlim([0 50])
% 
% 
% % Obtain the periodogram using fft. The signal is real-valued and has even length. Because the signal is real-valued, you only need power estimates for the positive or negative frequencies. In order to conserve the total power, multiply all frequencies that occur in both sets — the positive and negative frequencies — by a factor of 2. Zero frequency (DC) and the Nyquist frequency do not occur twice. Plot the result.
% 
% N = length(x);
% xdft = fft(x);
% xdft = xdft(1:N/2+1);
% psdx = (1/(Fs*N)) * abs(xdft).^2;
% psdx(2:end-1) = 2*psdx(2:end-1);
% freq = 0:Fs/length(x):Fs/2;
% 
% plot(freq,10*log10(psdx))
% grid on
% title('Periodogram Using FFT')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')
% xlim([0 50])
%% Pwelch

% pwelch(x,500,300,500,Fs);
% 
% plot(f,10*log10(pxx))
% 
% xlabel('Frequency (Hz)')
% ylabel('PSD (dB/Hz)')
%}