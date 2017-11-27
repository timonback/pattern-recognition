% All filenames
filenames = arrayfun(@(i) sprintf('../Data/person%02d.mat',i), 1:20, 'UniformOutput',false);
codes = loadIrisCodes(filenames);

s = calcSetS(10000, codes);
d = calcSetD(10000, codes);

%Question 1
ax1 = subplot(2,1,1);
bin_size = 50;
x = 0:(1/bin_size):1;
yyaxis left  
histogram(ax1, s, bin_size);
yyaxis right
histogram(ax1, d, bin_size);
axis([0 1 0 3000]);
print('histogram.png', '-dpng')

%Question 2-7
s_mean = vpa(mean(s));
s_variance = vpa(var(s));
d_mean = vpa(mean(d));
d_variance = vpa(var(d));

%Question 8-9
freedom = (power(d_mean, 2) * power(1 - d_mean, 2)) / power(d_variance, 2)

%Question 10
s_dist = normpdf(x, s_mean, 25*s_variance);
d_dist = normpdf(x, d_mean, 10*d_variance);

%clf % plot clear/empty
ax2 = subplot(2,1,2);
axis([0 1 0 3000]);

plot(x, 300*s_dist, x, 300*d_dist)
print('histogram_gauss.png', '-dpng')


% Question 11
% False Acceptance Rate (Error Type 1) is 0.0005
% 5 iris patterns that are the same are rejected (0.0005 * 10000)
% Use set S, use the gauss distribution
normcdf(s_dist, s_mean, s_variance);
% Not sure what the output exactly means... At -70 -> the value equals
% 20000 (1/0.0005). But this would make sense as d has is between 0 and 1

% Assuming, a normal the used normal distribution could be integrated
% easily: 
% Next step, integrate from -inf to d (pick/try different d) till the value
% will be 0.0005.


% Question 12
% This is exactly the opposite asked compared to Question 11
% Using now set D, the integral from d till +inf needs to be calculated
normcdf(d_dist, d_mean, d_variance);
% Again, unsure of the output...


% Question 13
% N = 1000
% Given that two bits are similiar is 0.7, it means that they are different
% by 0.3 (1-0.7)
% Thus, in average (mean) 300 bits are different mean = (N * 0,3)
% Normalized 0.3 (mean / 1000)

% Question 14-15
% Masking the invalid bits is not necessary, as they will be false with
% every persons iris scan (by xor)
testperson = load('../Data/testperson.mat');
pers = [];
for person = 1:20
    res = [];
    for row = 1:20
        ret = calcTestDifference(person, row, codes, testperson);
        res = [res ret];
    end
    
    pers = [pers mean(res)];
end
disp('showing the mean hamming distance to the test person')
disp(pers)


function diff = calcTestDifference(person2, row, codes, testperson)
  % All codes inner vectors have the same size. Therefore codes{1} =
  % codes{i}, where i is element in (1:20)

  person_codes_2 = codes{person2};
  diff = hammingDistanceNormalized( testperson.iriscode, ...
    person_codes_2(row, 1:end));
end


function iriscodes = loadIrisCodes(filenames)
  file_contents_raw = arrayfun(@(i) load(filenames{i}), 1:length(filenames));
  iriscodes = arrayfun(@(i) file_contents_raw(i).iriscode, 1:length(file_contents_raw), 'UniformOutput',false);
end

function diff = calcIrisDifference(person1, person2, codes)
  % All codes inner vectors have the same size. Therefore codes{1} =
  % codes{i}, where i is element in (1:20)
  person_row_random = randi(size(codes{1}, 1), 2,1);

  person_codes_1 = codes{person1};
  person_codes_2 = codes{person2};
  diff = hammingDistanceNormalized( ...
    person_codes_1(person_row_random(1), 1:end), ...
    person_codes_2(person_row_random(2), 1:end));
end

function dnorm = hammingDistanceNormalized(v1, v2)
  if length(v1) ~= length(v2)
      disp('Incorrect lenghts');
      disp(length(v1));
      disp(length(v2));
      dnorm = -1;
      return
  end
  d = xor(v1, v2);
  dnorm = sum(d) / length(v1);
end

function s = calcSetS(setSize, codes)
  s = zeros(setSize, 1);
  s = arrayfun(@(i) calcSamePersonEntry(codes), 1:length(s));
end
function s = calcSetD(setSize, codes)
  s = zeros(setSize, 1);
  s = arrayfun(@(i) calcDiffPersonEntry(codes), 1:length(s));
end

function res = calcSamePersonEntry(codes)  
  person = randi(length(codes), 1, 2);
  res = calcIrisDifference(person(1), person(1), codes);
end

function res = calcDiffPersonEntry(codes)  
  person = [0 0];
  while person(1) == person(2)
      person = randi(length(codes), 1, 2);
  end 
  res = calcIrisDifference(person(1), person(2), codes);
end

