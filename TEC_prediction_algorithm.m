
%Code written by Federico Migliosi
% This code requires the Statistics and Machine Learning Toolbox

clc;
clear;

%====================Data preprocessing====================

load tec_lat_lon.csv;

latitude = linspace(87.5,-87.5,71)';
longitude = linspace(-180,180,73)';

InputVector_hight = length(latitude)*length(longitude);

%Instantiation of the input vector to zero 
Input = zeros(InputVector_hight,2);

%Instantiation of the output vector to zero
Output = zeros(InputVector_hight,1);


%Unrolling of TEC values 
% in order to be inserted into the one-dimensional Output vector 

k=1;
for j=1:length(longitude)
    for i=1:length(latitude)
        Output(k)=tec_lat_lon(i,j);
        k=k+1;
    end
end
clear k i j;

%Creation of the input vector with all possible combinations of 
% latitude and longitude

for i=1:InputVector_hight
    Input(i,1)=latitude(modulo71(i));       
end
clear k j i;

for k=0:72
    for i=(1 + (71*k)):(length(latitude)+ (71*k))
        Input(i,2)=longitude(k+1);
    end
end
clear k i j;

%====================KNN training====================

%If your computer is as powerful as a toaster 
% then uncomment the code below and use it for the training phase.

%{
Mdl = fitcknn(Input,Output,'NumNeighbors',4,'Standardize',1);
%}



%If you are feeling brave instead
% uncomment the code below and use it for the training phase.

%{
Mdl = fitcknn(Input,Output,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'));
%}



%USE JUST ONE OF THE TWO OPTIONS ABOVE


%====================KNN prediction====================

%{
How to predict a new value:

predict(Mdl,["latitude","longitude"])

%}


