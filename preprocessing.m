function hungarian_mat = preprocessing(doctor_choices, capacities)
    % This function serves to process the input data doctors use to rank
    % hospitals, sanitizing inputs so that no errors are encountered upon
    % optimization as well as converts the data into a cost matrix for the
    % later implemented Hungarian Algorithm. Sanitization involves removing
    % repeat choices in the ranking, cutting of excess choices, and filling
    % in missing choices.
    % Inputs: 
    % -  doctor_choices: the choices submitted by doctors (Xx1 cell array
    %    containing up to N choices of hospitals in each cell
    %    submitted by X number of doctors on where they would like to work)
    % -  capacities: 1xN array of N hospitals with values corresponding to
    %    the capacity of each hospital 
    % Outputs: 
    % - hungarian_mat: Sanitized data with information on where
    %   each doctor would prefer to work with columns duplicated based on
    %   capacity ready for the hungarian algorithm in optimization function

    % Initalizing some useful variables like the number of doctors and
    % hostpitals in the dataset.
    numHos = length(capacities);
    numDoc = length(doctor_choices);
    total_cap = sum(capacities);
    
    % Displays an error and stops the function if there is not enough room in
    % all of the hospitals to match every doctor.
    if total_cap < numDoc
        display('Total hospital capacities is less than total number of doctors so matching can not be completed');
        return
    end
    
    % Checks each row of doctor choices and first removes any duplicate entries
    % while maintaining order. Then it removes any values that are not in.
    % the list of hospitals. Then it checks the row for any missing hospitals 
    % from the ranking and adds them to the end.
    for k = 1:length(doctor_choices)
        doctor_choices{k} = unique(doctor_choices{k}, 'stable');
        doctor_choices{k} = intersect(doctor_choices{k}, (1:numHos), 'stable');
        missing = setdiff((1:numHos), doctor_choices{k}, 'stable');
        doctor_choices{k} = [doctor_choices{k}, missing]; 
    end
    
    % Convert cell array to matrix now that they are cleaned and the same
    % length.
    if isequal(size(doctor_choices), [1, numDoc])
        doctor_choices = doctor_choices.';
    end
    doctor_mat = cell2mat(doctor_choices);
    
    % Create the cost matrix for the Hungarian Algorithm out of the rankings by
    % making mapping taking the first value of the doctor choicies matrix and 
    % mapping a 1 to the index of that corresponding value in the cost matrix.
    % example: doctor choices [3, 2, 4, 1], 3 is first choice, 4 is second ect.
    % is mapped to cost matrix [4, 2, 1, 3] each column represents a hospital 
    % the number represents the cost of putting a doctor in that hospital.
    cost_mat = zeros(numDoc, numHos);
        for k = 1:numDoc
            for i = 1:numHos
                cost_mat(k, doctor_mat(k,i)) = i;
            end
        end
      
    % The Hungarian Algorithm does 1-to-1 matching so to get around this the
    % column that represents each hostpital is duplicated based on the capacity
    % for the hospital to multiple matches can be done. 
    % example: hospital with capacity 3 will have the column in the cost matrix
    % duplicated 3 times.
    hungarian_mat = [];
    for h_index = 1:numHos
        hungarian_mat = [hungarian_mat, repmat(cost_mat(:, h_index), 1, capacities(h_index))];
    end
    
end
        
