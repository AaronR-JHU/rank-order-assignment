[capacity, test_data] = test();

[assignment, totalCost] = optimization(test_data);

assignments = test_data(assignment.');

% Display results
disp('Assignment:');
disp(assignment);
disp('Total Cost:');
disp(totalCost);