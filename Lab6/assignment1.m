data = load('data/kmeans1.mat');
data = data.kmeans1;

k_given = [2 4 8];

for k=k_given
    % calculate kmeans
    prototypes = my_kmeans_prototypes(data, k, 0);
    [means, closest, mu_tracking] = my_kmeans(data, k, prototypes);
        
    % Question 2
    hold off;
    ax1 = subplot(length(k_given), 2, find(k_given==k)*2-1);
    scatter(data(:, 1), data(:, 2), [], closest)
    hold on;
    for means_i = 1:length(means)
       plot(means(means_i,1), means(means_i,2), 'g*') 
    end
    title(['kmeans with ' num2str(k) ' clusters']);
    
    % Question 3
    hold off;
    ax2 = subplot(length(k_given), 2, find(k_given==k)*2);
    for i = 1:k
        % reshape is used, since mu_tracking(mu_tracking_i, 1,:) does not
        % work directly (Data cannot have more than 2 dimensions.)
       plot(...
           reshape(mu_tracking(i, 1,:), [1 size(mu_tracking, 3)]),...
           reshape(mu_tracking(i, 2, :), [1 size(mu_tracking, 3)]),...
           'r-')
        %plot_arrow(prototypes(i, 1), prototypes(i,2), means(i, 1), means(i, 2));
%         for iter = 1:size(mu_tracking, 3)-1
%             plot_arrow(mu_tracking(i, 1, iter), mu_tracking(i, 2, iter),...
%                 mu_tracking(i, 1, iter+1), mu_tracking(i, 2, iter+1));
%         end
        hold on;
    end
    title(['kmeans with ' num2str(k) ' clusters and tracked means']);    
    
    axis([ax1 ax2], [-5 5 -5 5])
end
print('kmeans.png', '-dpng')

% Quantization error
% Question 4
kmax = 20;
[error_q, reference, deriv] = my_kmeans_quant(data, 1:kmax, 0);
kopt = max(deriv);
disp(['kopt using up to ' num2str(kmax) ' clusters is ' num2str(kopt)]);

clf('reset');
hold off;
plot(1:length(deriv), deriv);
hold on;
plot(find(deriv==max(deriv)), max(deriv), 'gx');
title('kmeans (deriv)');
print('kmeans_deriv.png', '-dpng')

% Question 5
hold off;
plot(1:length(error_q), error_q, 1:length(reference), reference);
hold on;
plot(find(deriv==max(deriv)), max(deriv), 'gx');
title('kmeans (error+reference)');
legend('error','reference');
print('kmeans_error_reference.png', '-dpng')


