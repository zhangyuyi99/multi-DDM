function []=plotFFTdifference(nonAvgIqtau,theta,wavenumber,scale,q_range,tau,path)
%     data=load(filename);
       
    radius=scale/2+1;
    fig=figure();
    
    a=fftshift(nonAvgIqtau(:,:,tau));
    a(radius,radius)=0;
%     a=a';
    a(radius,radius,tau)=0;
    imagesc(a(radius-q_range:radius+q_range,radius-q_range:radius+q_range), 'XData', [-q_range q_range], 'YData', [-q_range q_range]);
%     hold on;
    
%     x = -q_range:0.1:q_range;
%     y = x*tan(-theta);
%     z = x/tan(theta);
%     plot(x,y,'LineStyle','--','Color','white','LineWidth',1,'Tag','perpendicular')
%     plot(x,z,'LineStyle','-','Color','white','LineWidth',1,'Tag','direction')
%     hold on;
%     viscircles([0,0],wavenumber,'Color',[1,1,1,0.2],'LineStyle','-','LineWidth',3);
    % text(x(end),y(end),'perpendicular');
    set(gca,'dataAspectRatio',[1 1 1])
    colorbar;
    xlabel('Mode $q_x$','Interpreter','latex');
    ylabel('Mode $q_y$','Interpreter','latex');
%     title(['theta=' num2str(theta) ', FFT difference at tau=' num2str(tau) 's'])
%     title(['FFT difference of $tau=$' num2str(tau) 's'],'Interpreter','latex')
    set(gca,'fontsize', 20);
    
%     saveas(fig,[path filename(1:end-4) '_FFTdifference_plot.png']);
end