function [X, Y] = transformForRNN(Data, SequenceLength, Feature)
% TRANSFORMFORRNN Transforms a set of data into a form usable for a
% recurrent neural network.
%
% `Data` must be an N x F matrix; where N is the number of observations,
% and F is the number of input features (variables) to the RNN.
%
% `SequenceLength` is the length of the input sequence to the RNN.
%
% `Feature` is the (index of the) primary feature, the one whose value
% is interpreted as the expected output. This will usually be the feature
% that gets graphed.
%
%
% The output `X` is a 'data cube', an M x 1 cell array of matrices.
% Each matrix has dimensions F x S, where F is still the number of
% features, and S is `SequenceLength`.
%
% The output `Y` is an M x 1 cell aray of numerical values: the expected
% outputs corresponding to the entries in `X`.
% Which feature is taken as the expected output is determined by the
% paramter `Feature`.
%
% M is the number of sequences able to be constructed from the original
% datta set. M = N - SequenceLength - 1.

F = size(Data, 2); % Number of features.
N = size(Data, 1); % Number of observations.

M = N - SequenceLength - 1;
X = cell(M, 1);
Y = cell(M, 1);
for i = 1:M
    X{i} = zeros(F, SequenceLength);
    for s = 1:SequenceLength
        for f = 1:F
            % Subtract '1' to prevent an off-by-one error.
            % Since matlab's indices start at 1 for some reason,
            % `i + s` ends up being 1 greater than we want.
            X{i}(f, s) = Data(i + (s-1), f);
        end
    end
    % This time, we DON'T subtract 1.
    % If this was a language with zero-based arrays,
    % we would actually add 1 here.
    Y{i} = Data(i + SequenceLength, Feature);
end

Y = cell2mat(Y);

end
