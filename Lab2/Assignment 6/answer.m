% Sentence 1
% We offer our dear customers a wide selection of classy watches
s1 = {'We', 'offer', 'our', 'dear', 'customers', 'a', 'wide', 'selection', 'of', 'classy', 'watches'};
s1_spam = bayes_spam(s1)

% Sentence 2
% Did you have fun on vacation? I sure did!
s2 = {'Did', 'you', 'have', 'fun', 'on', 'vacation', '?', 'I', 'sure', 'did', '!'};
s2_spam = bayes_spam(s2)


function res = bayes_spam(sentence)
    spam = 0.9;
    nonspam = 0.1; 

    words = {
        'Anti-aging';
        'Customers';
        'Fun';
        'Groningen';
        'Lecture';
        'Money';
        'Vacation';
        'Viagra';
        'Watches';
    };
    words = lower(words);
    score = [
        0.00062 	0.000000035;
        0.005       0.0001;
        0.00015 	0.0007;
        0.00001 	0.001;
        0.000015 	0.0008;
        0.002       0.0005;
        0.00025 	0.00014;
        0.001       0.0000003;
        0.0003      0.000004;
    ];

    sentence = lower(sentence);

    word_indexes = arrayfun(@(word) find(ismember(words, word)), sentence, 'UniformOutput', false);
    % Remove empty cells
    word_indexes = word_indexes(~cellfun('isempty', word_indexes));
    % Convert to vector
    word_indexes = cell2mat(word_indexes);

    sentence_spam = spam;
    sentence_nonspam = nonspam;
    for word_indexes_index = 1:length(word_indexes)
        word_index = word_indexes(word_indexes_index);
        sentence_spam = sentence_spam * score(word_index, 1);
        sentence_nonspam = sentence_nonspam * score(word_index, 2);
    end
    
    ratio = sentence_spam / sentence_nonspam;

    res = [sentence_spam sentence_nonspam ratio];
end

