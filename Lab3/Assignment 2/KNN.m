function class = KNN(point, K, data, dataClassAssoc)
  dist = squareform(pdist([point; data], 'euclidean')); % distance matrix
  
  % sort the distance to find the closest K.
  % the first distance is always to itself, so skip (start with 2)
  [sorted, index] = sort(dist(1, 2:end));
  closestClasses = zeros(K, 1);
  % copy the class of the K nearest
  for i=1:K
      closestClasses(i) = dataClassAssoc(index(i));
  end
  
  class = mode(closestClasses);
end
