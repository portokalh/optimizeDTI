gamma=267.513e6; % for H1, in rad/(s*T)
Grad=[65e-5 40e-5 20e-5]; % T/mm or (G/cm)e-5, this is the RMS of the amp_diffs x10^-5
Grad=sqrt(Grad.^2.*2);
% s, this is delta_diff x10^-6
b=zeros(25,3);
for i=1:length(Grad)
    G=Grad(4-i);
    for TE=6:30
        delta=(TE-6)/2;
        Delta=delta; % s, this is = (TE)-(hard90/2)-(delta_diff)-(pet)-(dwell_time*opxres/2)-(slop_time*2), essentially = TE-(4.675+(0.008*opxres/2))
        delta=delta/1000;
        Delta=Delta/1000;
        b(TE-5,i)=((gamma^2)*(G^2)*(delta^2)*((4*Delta)-delta))/(pi^2);
        %display(horzcat('calculated b-value for half sine = ',num2str(b)));
    end
end

p=plot(b);
set(p,'LineWidth',2)
set(gca,'YTickLabel',num2str(get(gca,'YTick')'))

xlabel('TE (ms)','FontSize',18)
ylabel('b_m_a_x (mm^2/s)','FontSize',18)
title('b_m_a_x vs TE','FontSize',24)
text(24,2.646639567017859e+03,'200 mT/m \rightarrow','HorizontalAlignment','right','FontSize',14)
text(24,1.058655826807143e+04,'400 mT/m \rightarrow','HorizontalAlignment','right','FontSize',14)
text(24,2.795513042662613e+04,'650 mT/m \rightarrow','HorizontalAlignment','right','FontSize',14)