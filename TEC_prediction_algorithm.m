
%Code written by Federico Migliosi
%This code require the Statistics and Machine Learning Toolbox

clc;
clear;

%Data preprocessing

load tec_lat_lon.csv;

latitude = linspace(87.5,-87.5,71)';
longitude = linspace(-180,180,73)';

altezza_input = length(latitude)*length(longitude);

Input = zeros(altezza_input,2);

Output = zeros(altezza_input,1);

k=1;

for j=1:length(longitude)
    for i=1:length(latitude)
        Output(k)=tec_lat_lon(i,j);
        k=k+1;
    end
end

clear k i j;

for i=1:altezza_input
    Input(i,1)=latitude(modulo71(i));       
end

clear k j i;


for k=0:72
    for i=(1 + (71*k)):(length(latitude)+ (71*k))
        Input(i,2)=longitude(k+1);
    end
end

clear k i j;

%KNN training

Mdl = fitcknn(Input,Output,'NumNeighbors',4,'Standardize',1);

%{
How to predict a new value:

predict(Mdl,["latitude","longitude"])

%}


