function [capacities, doctor_choices] = test(numHospitals, numDoctors)
    % This function serves to generate test data based on the number of
    % doctors and number of hospitals. We assume that each doctor can list
    % up to N choices given N hospitals.
    % Inputs: 
    % -  numDoctors: The number of doctors
    % -  numHospitals: The number of hospitals
    % Outputs: 
    % - doctor_choices: A Xx1 cell array for X doctors with doctor one having
    %   a vector of their rankings. (Has built in randomized data errors such
    %   as repeats, data thats too long, and data thats too short)
    %   randomized selections of hospitals for each doctor
    % - capacities: a 1xN array with each value corresponding to the
    %   capaity of that hospital

    % Generates some capacities for each of the hospitals with maximum
    % capacites capped at the number of doctors divided by 5 rounded up so
    % that one hospital does not get randomized to have way more capacity.
    capacities = randi([1, ceil(numDoctors/5)], 1, numHospitals);

    % Sums the capacities and makes sure that the total capacity if greater
    % than the number of doctors. If it is not it takes a random index and
    % from the capacities vector and adds one before checking the sum
    % again.
    sumCap = sum(capacities);
    while numDoctors > sumCap
        randind = randi(numHospitals); 
        capacities(randind) = capacities(randind) + 1;
        sumCap = sum(capacities);
    end

    % Intialize an empty cell array to put randomized rankings in.
    doctor_choices = {};

    % Loops through once for each doctor and adds a vector to the cell
    % array that is a random ranking of the hospitals.
    for i = 1:numDoctors
        doctor_choices{i} = randperm(numHospitals, numHospitals);
    end
    
    % Adds some random errors to the data that might appear in real data.
    % It loops through the rounded up number of the number of doctors
    % divided by 2.5. Each loop it chooses a random index and appends on an
    % extra random value that is in the range of the number of hospitals.
    % then it takes another random index for the doctors and a random index
    % of the hospitals and it adds 1 to it to simulate someone repeating a
    % number in the rankings or putting a number in that is beyond the
    % number of hosptials. It generated one final random index and cuts
    % off the length of the vector at number of hospitals -1 to simulate
    % someone not ranking all of the hospitals.
    for k = 1:(ceil(numDoctors/2.5))
        rand2 = randi(numDoctors);
        doctor_choices{rand2} = [doctor_choices{rand2}, randi(numHospitals)];
        rand3 = randi(numDoctors);
        rand4 = randi(numHospitals);
        doctor_choices{rand3}(rand4) = doctor_choices{rand3}(rand4) + 1;
        rand5 = randi(numDoctors);
        doctor_choices{rand5} = doctor_choices{rand5}(1:numHospitals-1);
    end

end
