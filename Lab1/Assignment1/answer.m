load('../Data/lab1_1.mat')

C = corrcoef(lab1_1)

c_1 = lab1_1(1:end, 1);
c_2 = lab1_1(1:end, 2);
c_3 = lab1_1(1:end, 3);

%ax1 = subplot(2,1,1);
scatter(c_1, c_3, 'r')
xlabel('Feature 1 - Height in cm')
ylabel('Feature 3 - weight in kg')
legend(strcat('Correlation: ', num2str(C(1,3))), 'location', 'NorthWest')
print('result_1.png', '-dpng')

%ax2 = subplot(2,1,2);
scatter(c_2, c_3, 'r')
xlabel('Feature 2 - Age in years')
ylabel('Feature 3 - weight in kg')
%ax2.XAxisLocation = 'top';
legend(strcat('Correlation: ', num2str(C(2,3))), 'location', 'NorthWest')
print('result_2.png', '-dpng')
