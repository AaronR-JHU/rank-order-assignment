disp('Example 1: Very simple Case');
capacities1 = [1, 1, 1];  % One seat per hospital

doctor_choices1 = { [1,2,3], [2,3,1], [3,1,2] }; 
% Doctor 1 prefers H1 > H2 > H3
% Doctor 2 prefers H2 > H3 > H1
% Doctor 3 prefers H3 > H1 > H2

hungarian_mat1 = preprocessing(doctor_choices1, capacities1); % Get cost matrix
[assignment1, totalCost1] = optimization(hungarian_mat1, capacities1); % Obtain assignments with Hungarian
fprintf('\nCapacities: '); disp(capacities1);
fprintf('Doctor choices:\n'); disp(doctor_choices1);
fprintf('Hungarian cost matrix:\n'); disp(hungarian_mat1);
fprintf('Total cost: %d\n', totalCost1);
%% 
disp('Example 2: Case with hand-written solution');

capacities2 = [2, 2, 1]; % Two seats for H1, H2, one for H3

doctor_choices2 = {
    [1, 2, 3],   % Doctor 1 prefers H1 > H2 > H3
    [2, 1, 3],   % Doctor 2 prefers H2 > H1 > H3
    [1, 3, 2],   % Doctor 3 prefers H1 > H3 > H2
    [3, 2, 1]    % Doctor 4 prefers H3 > H2 > H1
};

hungarian_mat2 = preprocessing(doctor_choices2, capacities2); % Get cost matrix
[assignment2, totalCost2] = optimization(hungarian_mat2, capacities2); % Obtain assignments with Hungarian

fprintf('\nCapacities: '); disp(capacities2);
fprintf('Doctor choices:\n'); disp(doctor_choices2);
fprintf('Hungarian cost matrix:\n'); disp(hungarian_mat2);
fprintf('Total cost: %d\n', totalCost2);

% Hand-written solution with Hungarian steps:
% Original cost matrix (doctor rows and hospital seat columns) 
%       H1 H1 H2 H2 H3
% D1    1  1  2  2  3
% D2    2  2  1  1  3
% D3    1  1  3  3  2
% D4    3  3  2  2  1
%
% Step 1: Row reduction (subtract the minimum of each row from that row)
%       H1 H1 H2 H2 H3
% D1    0  0  1  1  2
% D2    1  1  0  0  2
% D3    0  0  2  2  1
% D4    2  2  1  1  0
%
% Step 2: Column reduction (subtract the minimum of each column from that column)
%       H1 H1 H2 H2 H3
% D1    0  0  1  1  2
% D2    1  1  0  0  2
% D3    0  0  2  2  1
% D4    2  2  1  1  0
%
% Step 3: Zero crossing
% D1: H1, D2 : H2, D3 : H1, D4 : H3
%
% Total cost = 4


%% 
disp('Example 3: More capacity than doctors');
[capacities3, doctor_choices3] = test(3, 3); % 3 hospitals, 3 doctors
capacities3 = capacities3 + 1;  % Extra capacity
hungarian_mat3 = preprocessing(doctor_choices3, capacities3);
[assignment3, totalCost3] = optimization(hungarian_mat3, capacities3);
fprintf('\nCapacities: '); disp(capacities3);
fprintf('Doctor choices:\n'); disp(doctor_choices3);
fprintf('Hungarian cost matrix:\n'); disp(hungarian_mat3);
fprintf('Total cost: %d\n', totalCost3);


%% 
disp('Example 4: More doctors than capacity');
%Intended to produce error 

[~, doctor_choices4] = test(3, 5); % 3 hospitals, 5 doctors
capacities4 = [1,1,2];  % total capacity 4 < 5 doctors
hungarian_mat4 = preprocessing(doctor_choices4, capacities4);
fprintf('Capacities: '); disp(capacities4);
fprintf('Doctor choices:\n'); disp(doctor_choices4);
fprintf('Hungarian cost matrix:\n'); disp(hungarian_mat4);
[assignment4, totalCost4] = optimization(hungarian_mat4, capacities4);
fprintf('Total cost: %d\n', totalCost4);


