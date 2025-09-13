Rank-Order Assignment

Biomedical Data Design - Rank Order Code

This repository provides MATLAB code to solve a rank-order assignment problem, matching N doctors with K hospitals based on doctor preferences.

The implementation uses the Hungarian algorithm (see reference below) to maximize overall doctor satisfaction. Preferences are converted into costs:

A doctor’s top preference has a cost of 1.

Each subsequent rank increases the cost by 1.

The algorithm minimizes the total cost, and thereby maximizes overall satisfaction.

The code allows for hospitals with varying capacities. However, the total hospital capacity must be greater than or equal to the number of doctors being assigned.

Files

demo.m: Example applications of the code. test.m, preprocessing.m, optimization.m, and munkres.m must be in the WD. 

test.m: Generates test data (hospital capacities and doctor preference orders) given a number of doctors and hospitals.

preprocessing.m: Generates a cost matrix from the hospital capacities and doctor preferences, handling inconsistencies such as cases where doctors do not rank every hospital and adjusting for varied hospital capacities.

optimization.m: Obtains the optimal doctor-hospital assignments using the Hungarian algorithm given the cost matrix. 

munkres.m: Hungarian algorithm implementation (see reference). 

Authors

Joey Roberts: preprocessing.m, test.m

Aaron Roitman: test.m, optimization.m, demo.m

Sibi Pandian (spandia2@jh.edu) : test.m, optimization.m, demo.m

Reference

Munkres' Assignment Algorithm, Modified for Rectangular Matrices
http://csclab.murraystate.edu/bob.pilgrim/445/munkres.html

Version 2.3 by Yi Cao, Cranfield University, 11 September 2011


