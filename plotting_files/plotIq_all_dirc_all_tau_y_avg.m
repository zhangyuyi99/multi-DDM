function []=plotIq_all_dirc_all_tau(filename,path,wavelength,scale,q_max)
    load(filename);
    angle_num=size(angle_Iqtau,1);
    qVec=1:size(angle_Iqtau,2);
    q_num=size(angle_Iqtau,2);
    tVec=1:size(angle_Iqtau,3);
    t_num=size(angle_Iqtau,3);
    fig=figure();
    y=sum(sum(angle_Iqtau(1:16,(1:q_max),:),1),3);
    
    [distance_map, dist_counts] = create_distance_map(scale);
    y_avg=y(:)./dist_counts(1:q_max);
    
    semilogx(qVec(1:q_max),squeeze(y_avg),"LineWidth",1)
% % %     lambda=wavelength;
% % %     hxl = xline(scale/lambda,'-',{'q_{wave}, manually'},'LabelOrientation','horizontal','LineWidth',1);
% % % %     hxl_g = xline(1/lambda,'-',{'q_{grid}'},'LabelOrientation','horizontal','LineWidth',1);
% % %     hxl.FontSize = 16;
%     hxl_g.FontSize=16;
    ylim([0 1.2*max(y_avg)]);
%     xticks([0 0.001 0.01 0.1])
    set(gca,'fontsize', 16); 
%     xlabel('q, [pixel^{-1}]')
    xlabel('q, [wavenumber]')
    ylabel('I(q)')
    title('Sum of all directions, all taus')
%     saveas(fig, [path filename(1:end-4) '_Iq-q.png']);
end
