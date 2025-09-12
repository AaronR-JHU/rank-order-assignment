% Generated test data with 5 hositpals and 10 doctors
[capacities, doctor_choices] = test(5, 10);

% Some hard coded data
% doctor_choices = {[4,1,1,3,6],
%                   [1,5,3,2,4],
%                   [2,3,5,1],
%                   [3,5,4,2,2],
%                   [1,1,1,3],
%                   [3,2,5,4,1],
%                   [2,3,4,1,5,6],
%                   [2,3,5,1,1,4],
%                   [1,4,3],
%                   [1,5,6,8,2,3,4]};
% capacities = [2,1,2,3,4];

% Process the input data to create a matrix to put into the hungarian
hungarian_mat = preprocessing(doctor_choices, capacities);

[assignment, totalCost] = optimization(hungarian_mat, capacities);

% Display results
disp(totalCost);