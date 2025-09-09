function filtered_choices = preprocessing(doctor_choices, capacities)
    % This function serves to process the input data doctors use to rank
    % hospitals, sanitizing inputs so that no errors are encountered upon
    % optimization
    % Inputs: 
    % -  doctor_choices: the choices submitted by doctors (XxN array
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
% of 

% Process incomplete data (less than 5 entries)

% Process bad data (same hospital twice)
