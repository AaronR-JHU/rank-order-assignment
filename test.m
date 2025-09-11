function [capacity, cost_mat] = test()
% Initialize parameters for test data generation
    numHospitals = 5; 
    capacity = randi([1, 5], 1, numHospitals);
    numDoctors = sum(capacity);
    cost_mat = generate_test_data(numDoctors, numHospitals);
    cost_mat = hungarian_test_data(capacity, cost_mat, numDoctors);

end

function cost_mat = generate_test_data(num_doctors, num_hospitals)
    % This function serves to generate test data based on the number of
    % doctors and number of hospital. We assume that each doctor can list
    % up to N choices given N hospitals
    % Inputs: 
    % -  num_doctors: The number of doctors
    % -  num_hospitals: The number of hospitals
    % Outputs: 
    % - test_data: A XxN array for X doctors and N hospitals with
    %   randomized selections of hospitals for each doctor

    % Generate random hospital choices for each doctor
    test_data = zeros(num_doctors, num_hospitals);
    for i = 1:num_doctors
        test_data(i, :) = randperm(num_hospitals, num_hospitals);
    end

    % Sort input into cost matrix by looking at value of first entry and map 1 to that index,
    % in the cost matrix, look at second value map 2 to that index ect.
    cost_mat = zeros(num_doctors, num_hospitals);
    for k = 1:num_doctors
        for i = 1:num_hospitals
            cost_mat(k, test_data(k,i)) = i;
        end
    end
 
end

function cost_mat = hungarian_test_data(capacity, cost_mat, numDoctors)
    cost_mat_updated = [];
    for h_index = 1:length(capacity)
        cost_mat_updated = [cost_mat_updated, repmat(cost_mat(:, h_index), 1, capacity(h_index))];
    end
    cost_mat = cost_mat_updated;
end
    
