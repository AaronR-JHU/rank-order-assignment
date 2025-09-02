% Piority should be given at random to people.
% The optimization method that we could use is Hungarian Algorithm 
% to maximize global satifaction for a group of roughtly 1000 doctors.
% Unmatched doctors are held to the end of assigment and then assigned to
% the hopital with the most need (least number of doctors).

function [assignment, totalCost] = optimization(input_data)
    % Initialize the cost matrix based on input data
    % Check if the cost matrix is square
    [numRows, numCols] = size(input_data);
    if numRows ~= numCols
        error('Cost matrix must be square.');
    end

    % Use the built-in 'munkres' function if available
    assignment = munkres(input_data);

    % Calculate the total cost of the assignment
    totalCost = sum(input_data(sub2ind(size(input_data), 1:numRows, assignment)));
end