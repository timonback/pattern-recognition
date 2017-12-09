lab3_2 = load('../Data/lab3_2.mat');
data = lab3_2.lab3_2;

samples=64;

%%%
% Create KNN maps with two classes
nr_of_classes = 2;
class_labels = genLabels(data, nr_of_classes);
showKNN(1, nr_of_classes, data, samples, class_labels);
showKNN(3, nr_of_classes, data, samples, class_labels);
showKNN(5, nr_of_classes, data, samples, class_labels);
showKNN(7, nr_of_classes, data, samples, class_labels);

% KNN error with two classes
calcKnnError(data, nr_of_classes, class_labels)

%%%
% Create KNN maps with four classes
nr_of_classes = 4;
class_labels = genLabels(data, nr_of_classes);
showKNN(1, nr_of_classes, data, samples, class_labels);
showKNN(3, nr_of_classes, data, samples, class_labels);
showKNN(5, nr_of_classes, data, samples, class_labels);
showKNN(7, nr_of_classes, data, samples, class_labels);

% KNN error with four classes
calcKnnError(data, nr_of_classes, class_labels)

function showKNN(K, nr_of_classes, data, samples, class_labels)
    % Sample the parameter space
    result=zeros(samples);
    for i=1:samples
      X=(i-1/2)/samples;
      for j=1:samples
        Y=(j-1/2)/samples;
        result(j,i) = KNN([X Y],K,data,class_labels);
      end
    end

    % Show the results in a figure
    imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
    hold on;
    title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);
    
    % this is only correct for the first question
    scaled_data=samples*data;
    plot(scaled_data(  1:50 ,1),scaled_data(  1:50, 2),'go');
    plot(scaled_data( 51:100,1),scaled_data( 51:100,2),'ro');
    plot(scaled_data(101:150,1),scaled_data(101:150,2),'b+');
    plot(scaled_data(151:200,1),scaled_data(151:200,2),'c+');
    
    print(['KNN_' int2str(K) '_' int2str(nr_of_classes) 'cls.png'], '-dpng')
    hold off;
end

function calcKnnError(data, nr_of_classes, class_labels)
    % Error for KNN
    count=0;
    for k=1:33
      if mod(k, 2) == 1
        count = count +1;
        model = fitcknn(data, class_labels, 'NumNeighbors', k);
        cvmodel = crossval(model, 'LeaveOut', 'on');
        cvError = kfoldLoss(cvmodel, 'lossfun', 'classiferror');
        val(count, :) = [k cvError];
      end
    end
    % val contains the K to error value mapping now
    plot(val(:, 1), val(:, 2))
    print(['KNN_error_' int2str(nr_of_classes) 'cls.png'], '-dpng')
end

function labels = genLabels(data, labelCount)
  labels = floor( (0:length(data)-1) * labelCount / length(data) );
end
