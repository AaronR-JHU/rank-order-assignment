function [assignment, totalCost] = optimization(input_data, capacity)
    % This function uses the Hungarian algorithm to select the optimal 
    % hospital-doctor assignments based on the user-inputted cost matrix.
    % Inputs: 
    % - input_data: MxS array (cost matrix), where M is the number of doctors
    %   and S is the total number of hospital seats (sum of capacities).
    %   Each column corresponds to a seat in a hospital, and multiple columns
    %   for a hospital must appear consecutively. For example, if Hospital 1 has
    %   capacity 2 and Hospital 2 has capacity 3, then the first 2 columns
    %   correspond to Hospital 1’s seats and the next 3 columns correspond to
    %   Hospital 2 s seats. Each row gives the assignment costs (see README)
    %   for one doctor.
    % - capacity: 1xN array of N hospitals with values corresponding to
    %    the capacity (number of seats) of each hospital 
    % Outputs: 
    % - assignment: 1xM array, where the kth entry is the hospital index 
    %   assigned to the kth doctor
    % - totalCost: Scalar containing total cost of optimal assignment 
   
    % Check if the cost matrix is square
    [numDocs, numSeats] = size(input_data);
    if numDocs < numSeats
        % Adds rows of value inf so hungarian can be run on non-square
        % matrix
        disp('Dummy rows added')
        input_data = [input_data; inf*ones(numSeats-numDocs, numSeats)]; 
    end

    % Displays an error and stops the function if there is not enough room in
    % all of the hospitals to match every doctor.
    if numSeats < numDocs %Total capacity less than num of doctors
        error('Total hospital capacity (%d) is less than the number of doctors (%d). Matching cannot be completed.', numSeats, numDocs);
    end

    % Obtain optimal assignment using Hungarian algorithm 
    assignment = munkres(input_data);

    % Trim assignment to the original number of doctors (exclude dummy rows)
    assignment = assignment(1:numDocs);

    % Identify the cost of each doctor's assigned seat (row k, column assignment(k))
    % and sum them to obtain the total assignment cost
    totalCost = sum(input_data(sub2ind(size(input_data), 1:numDocs, assignment)));

    % Correct assignments vector such that they correspond to the hospital
    % assigned to each doctor, rather than the seat 
    assignment = correct_hospital_assignments(assignment, capacity);

    % Print out the list of which doctor is assigned to which hospital
    for k = 1:length(assignment)
        fprintf('Doctor %d assigned to Hospital %d\n', k, assignment(k));
    end
end

function corrected_assignment = correct_hospital_assignments(og_assignment, capacity)
    % This function converts the seat-based assignments into hospital-based
    % assignments. 
    %
    % Inputs:
    % - og_assignment: 1xM array, where the kth entry is the hospital seat (column
    %   of cost matrix) assigned to the kth doctor. 
    % - capacity: 1xN array of N hospitals with values corresponding to
    %   the capacity (number of seats) of each hospital
    %
    % Output:
    % - corrected_assignment: 1xM array, where the kth entry is the hospital index
    %   assigned to the kth doctor

    % Initialize a lookup list for mapping each seat to its hospital
    hospital_capacity_list = [];
    for h_index = 1:length(capacity)
        % Repeat the hospital index according to its capacity
        % e.g., if hospital 2 has capacity 3, then [2 2 2] is appended
        hospital_capacity_list = [hospital_capacity_list, repmat(h_index, 1, capacity(h_index))];
    end

    % Use the lookup list to convert seat assignments into hospital assignments
    corrected_assignment = hospital_capacity_list(og_assignment);
end












