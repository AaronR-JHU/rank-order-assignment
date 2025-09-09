[capacity, cost_mat] = test();

[assignment, totalCost] = optimization(cost_mat, capacity);

% Display results
disp(totalCost);