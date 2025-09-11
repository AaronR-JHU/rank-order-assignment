function filtered_choices = preprocessing(doctor_choices, capacities)
    % This function serves to process the input data doctors use to rank
    % hospitals, sanitizing inputs so that no errors are encountered upon
    % optimization as well as converts the data into a cost matrix for the
    % later implemented Hungarian Algorithm. Sanitization involves removing
    % repeat choices in the ranking, cutting of excess choices, and filling
    % in missing choices.
    % Inputs: 
    % -  doctor_choices: the choices submitted by doctors (XxN cell array
    %    containing up to N choices of hospitals submitted by X number of 
    %    doctors on where they would like to work)
    % -  capacities: 1xN array of N hospitals with values corresponding to
    %    the capacity of each hospital 
    % Outputs: 
    % - filtered_choices: Sanitized data with information on where
    %   each doctor would prefer to work
    % - hospital_capacity: how many doctors can work at each hospital

% Given a cell array of the of the ranked list of hospitals per doctor
% we first go through remove any duplicate entries in the rankings. Next 
% remove the last entry of the ranking if it is more than the listed number
% of hospitals. Finally, search rankings that are short of choices for the
% missing choices and add them to the end of the rankings.
% After processing convert the cell matrix into a matrix and then sort the
% entries into a cost matrix for the Hungarian algorthm that we use then
% duplicate the columns of the array based on the capacites of each
% hostpital.

% Initalizing some useful variables like the number of doctors and
% hostpitals in the dataset.
numHos = length(capacities);
numDoc = length(doctor_choices);
hospitals = (1:numHos);

% Checks each row of doctor choices and first removes any duplicate entries
% while maintaining order. Then it truncates the row to the length of the
% number of hospitals so there is 1 choice for each hospital. Then it
% checks the row for any missing hospitals from the ranking and adds them
% to the end.
for k = 1:length(doctor_choices)
    doctor_choices{k} = unique(doctor_choices{k}, 'stable');
    if length(doctor_choices{k}) > numHos
        doctor_choices{k} = doctor_choices{k}(1:numHos);
    end
    missing = setdiff(doctor_choices{k}, hospitals, 'stable');
    doctor_choices{k} = [doctor_choices{k}, missing]; 
end

% Convert cell array to matrix now that they are cleaned and the same
% length.
doctor_mat = cell2mat(doctor_choices);

% Create the cost matrix out of the rankings by making mapping a 1 to the
% index of the first value of the cost mat
cost_mat = zeros(numDoc, numHos);
    for k = 1:numDoc
        for i = 1:numHos
            cost_mat(k, doctor_mat(k,i)) = i;
        end
    end
  
% Duplicate columns of the cost matrix based on the capacity for the
% hospital that the column represents. ex hospital with capacity 3 with
% have the column duplicated 3 times.

% Placeholder so i can test the other parts
filtered_choices = cost_mat
