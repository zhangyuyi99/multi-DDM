function []=plotIq_all_dirc_all_tau(angle_Iqtau,path,wavelength,scale,q_max)

    angle_num=size(angle_Iqtau,1);
    qVec=1:size(angle_Iqtau,2);
    q_num=size(angle_Iqtau,2);
    tVec=1:size(angle_Iqtau,3);
    t_num=size(angle_Iqtau,3);
    fig=figure();
%     y=sum(sum(angle_Iqtau(1:16,(1:q_max),:),1),3);
    y=sum(sum(angle_Iqtau(:,1:q_max,:),1),3);
    
%     [distance_map, dist_counts] = create_distance_map(scale);
%     y_avg=y(:)./dist_counts(1:q_max);
%     
    semilogx(qVec(1:q_max),squeeze(y),"LineWidth",1)
% % %     lambda=wavelength;
%     hxl = xline(scale/lambda,'-',{'q_{1}'},'LabelOrientation','horizontal','LineWidth',1);
%     hxl_g = xline(1/lambda,'-',{'q_{2}'},'LabelOrientation','horizontal','LineWidth',1);
    hxl = xline(wavelength,'-',{'q_{wave}, manually'},'LabelOrientation','horizontal','LineWidth',1);
%%% for combined waves
%     hxl = xline(3*sqrt(2),'-',{'q_{1}'},'LabelOrientation','horizontal','LineWidth',1);
%     hxl_g = xline(sqrt(6^2+3^2),'-',{'q_{2}'},'LabelOrientation','horizontal','LineWidth',1);

%     hxl.FontSize = 10;
%     hxl_g.FontSize=10;
%     ylim([0 1.2*max(y_avg)]);
    ylim([0 1.2*max(y)]);
%     xticks([0 0.001 0.01 0.1])
    set(gca,'fontsize', 12); 
%     xlabel('q, [pixel^{-1}]')
    xlabel('q, [wavenumber]')
    ylabel('I(q)')

%     split_filename=split(filename,'_');
%     v=split_filename(1);
%     v=v{1};
%     title(['Sum of all directions, all taus for ' v])
    title(['Sum of all directions, all taus'])
%     saveas(fig, [path filename(1:end-4) '_Iq-q.png']);
end
