% Piority should be given at random to people.
% The optimization method that we could use is Hungarian Algorithm 
% to maximize global satifaction for a group of roughtly 1000 doctors.
% Unmatched doctors are held to the end of assigment and then assigned to
% the hopital with the most need (least number of doctors).

function [assignment, totalCost] = optimization(input_data, capacity)
    % Initialize the cost matrix based on input data
    % Check if the cost matrix is square
    [numRows, numCols] = size(input_data);
    if numRows ~= numCols
        % Adds rows of value inf so hungarian can be run
        disp('Dummy rows added')
        input_data = [input_data; inf*ones(numCols-numRows, numCols)]; 
    end

    % Use the built-in 'munkres' function if available
    assignment = munkres(input_data);

    % Corrects the assignment vector to show the mutiple capacity of each
    % hospital
    assignment = assignment(:,1:numRows);
    assignment = mod(assignment - 1, numCols/capacity) + 1;

    % Calculate the total cost of the assignment
    totalCost = sum(input_data(sub2ind(size(input_data), 1:numRows, assignment)));

    % Print out the list of which doctor is assigned to which hospital
    for k = 1:length(assignment)
        fprintf('Doctor %d assigned to Hospital %d\n', k, assignment(k));
end
