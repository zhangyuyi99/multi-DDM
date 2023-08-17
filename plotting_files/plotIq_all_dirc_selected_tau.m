function []=plotIq_all_dirc_selected_tau(angle_Iqtau,tau,path,wavenumber,scale,q_max,fps)
%     load(filename);
%     angle_num=size(angle_Iqtau,1);
    qVec=1:size(angle_Iqtau,2);
%     q_num=size(angle_Iqtau,2);
%     tVec=1:size(angle_Iqtau,3);
%     t_num=size(angle_Iqtau,3);
    fig=figure();
    y=sum(angle_Iqtau(:,1:q_max,tau),1);
    
%     [distance_map, dist_counts] = create_distance_map(scale);
%     y_avg=y(:)./dist_counts(1:q_max);
%     
    
    %%  for all other videos
%     semilogx(qVec(1:q_max)/scale,squeeze(y),"LineWidth",1)

    %%  for Finnland wheat videos
%     semilogx(qVec(1:q_max)*2*pi/scale*11.8961,squeeze(y),"LineWidth",2)
%     hxl = xline(wavenumber*2*pi/scale*11.8961,'-',{'q_{wave}, manually'},'LabelOrientation','horizontal','LineWidth',2);

    %% for circle model videos
    lambda=32;
    semilogx(qVec(1:q_max)*2*pi/scale,squeeze(y),"LineWidth",2)
    hxl = xline(wavenumber*2*pi/scale,'-',{'q_{wave}, manually'},'LabelOrientation','horizontal','LineWidth',2);
    %% for closeup water videos
%     semilogx(qVec(1:q_max)*2*pi*128.386/scale,squeeze(y),"LineWidth",2)
% % %     lambda=wavelength;
%     hxl = xline(wavenumber*2*pi*128.386/scale,'-',{'q_{wave}, manually'},'LabelOrientation','horizontal','LineWidth',2);
%     hxl = xline(wavenumber/scale,'-',{'q_{wave}, manually'},'LabelOrientation','horizontal','LineWidth',1);
    
%     hxl_g = xline(lambda/scale,'-',{'q_{grid}'},'LabelOrientation','horizontal','LineWidth',1);
    hxl.FontSize = 20;
%     hxl_g.FontSize=20;
%     ylim([0 1.2*max(y_avg)]);
    ylim([0 1.2*max(y)]);
%     xticks([0 0.001 0.01 0.1])
    set(gca,'fontsize', 20); 
%%   for all videos
    xlabel('Spatial frequency $q$, [$pixel^{-1}$]','Interpreter','latex')
%%   for Finnland wheat videos
%     xlabel('Spatial frequency $q$, [$m^{-1}$]','Interpreter','latex')
%%   for closeup water videos
%     xlabel('Spatial frequency $q$, [$cm^{-1}$]','Interpreter','latex')

%     xlabel('Spatial frequency q, [cm^{-1}]','Interpreter','tex')
    ylabel(['$I(q,\tau''=' num2str(round(tau/fps,2)) 's)$'],'Interpreter','latex')
%     title(['Sum of all directions for \tau=' num2str(tau/10) 's'],'Interpreter','tex')
%     saveas(fig, [path filename(1:end-4) '_Iq-q.png']);
end
