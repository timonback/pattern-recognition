load('../Data/lab1_1.mat')

C = corrcoef(lab1_1)

c_1 = lab1_1(1:end, 1);
c_2 = lab1_1(1:end, 2);
c_3 = lab1_1(1:end, 3);

ax1 = subplot(2,1,1);
scatter(ax1, c_3, c_1)
xlabel('Feature 3 - weight in kg')
ylabel('Feature 1 - Height in cm')
legend(strcat('Correlation: ', num2str(C(1,3))), 'location', 'NorthWest')

ax2 = subplot(2,1,2);
scatter(ax2, c_3, c_2)
ylabel('Feature 2 - Age in years')
ax2.XAxisLocation = 'top';
legend(strcat('Correlation: ', num2str(C(2,3))), 'location', 'NorthWest')

print('result.png', '-dpng')
