function [capacity, test_data] = test()
% Initialize parameters for test data generation
    numDoctors = 10; 
    numHospitals = 5; 
    capacity = ceil(numDoctors/numHospitals);
    test_data = generate_test_data(numDoctors, numHospitals);
    test_data = hungarian_test_data(capacity, test_data, numDoctors);
end

function test_data = generate_test_data(num_doctors, num_hospitals)
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
    % to sort to cost look at value of first entry and map 1 to that index,
    % look at second value map 2 to that index ect.
end

function test_data = hungarian_test_data(capacity, test_data, numDoctors)
    test_data = repmat(test_data, capacity);
    test_data = test_data(1:numDoctors, :);
end
    