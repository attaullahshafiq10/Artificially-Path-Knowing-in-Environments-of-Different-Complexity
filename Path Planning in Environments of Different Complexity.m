% attaullahshafiq10@gmail.com
% Attauillah Shafiq

clear all


% Import Example Maps for Planning a Path
load exampleMaps.mat
whos *Map*
map = binaryOccupancyMap(simpleMap,2);
show(map)

% Define Robot Dimensions and Inflate the Map
robotRadius = 0.2;
mapInflated = copy(map);
inflate(mapInflated,robotRadius);

% Display inflated map
show(mapInflated)

% Construct PRM and Set Parameters
prm = mobileRobotPRM;
prm.Map = mapInflated;
prm.NumNodes = 50;
prm.ConnectionDistance = 5;

% Find a Feasible Path on the Constructed PRM
startLocation = [2 1];
endLocation = [12 10];
path = findpath(prm, startLocation, endLocation)
show(prm)

% Use PRM for a Large and Complicated Map
map = binaryOccupancyMap(complexMap,1);
show(map)

% Inflate the Map Based on Robot Dimension
mapInflated = copy(map);
inflate(mapInflated, robotRadius);
show(mapInflated)

% Associate the Existing PRM Object with the New Map and Set Parameters
prm.Map = mapInflated;
prm.NumNodes = 20;
prm.ConnectionDistance = 15;
show(prm)

% Find a Feasible Path on the Constructed PRM
startLocation = [3 3];
endLocation = [45 35];
path = findpath(prm, startLocation, endLocation);
 while isempty(path)
    % No feasible path found yet, increase the number of nodes
    prm.NumNodes = prm.NumNodes + 10;
    
    % Use the |update| function to re-create the PRM roadmap with the changed
    % attribute
    update(prm);
    
    % Search for a feasible path with the updated PRM
    path = findpath(prm, startLocation, endLocation);
 end

 path
 
 show(prm)
 
