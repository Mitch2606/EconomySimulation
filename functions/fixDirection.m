function [outputArray] = fixDirection(inputArray,direction)
%FIXDIRECTION Summary of this function goes here
%   Returns the input array so it lays either [1:2] or [1:2]'

sizes = size(inputArray);

if((sizes(1) > sizes(2)) && (direction == 1))
    %[1:5]
    outputArray = inputArray;
    
elseif((sizes(1) > sizes(2)) && (direction == 2))
    %[1:5]'
    outputArray = inputArray';
    
elseif((sizes(1) < sizes(2)) && (direction == 1))
    %[1:5]
    outputArray = inputArray';
    
elseif((sizes(1) < sizes(2)) && (direction == 2))
    %[1:5]'  
    
    outputArray = inputArray;
    
else
    disp("fixDirection : Broke!")
end

    
end


