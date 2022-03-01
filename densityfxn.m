mu = 0;
noise = 1;
x = -3*noise:1e-3:3*noise; 
y1 = .5*pdf('normal', x, -1, noise);
y2 = .5*pdf('normal', x, 1, noise);
plot(x, y1,'LineWidth',2.0)
hold on 
plot(x, y2, 'r','LineWidth',2.0)
legend({'P(X=-1)P(Y|X=-1)', 'P(X=1)P(Y|X=1)'},'FontSize',13)
xlabel('Y = y') 
ylabel('Probability Probability')
set(gcf,'color','w');
set(gca,'Color','w');
title('Probability Density Function for Detector')