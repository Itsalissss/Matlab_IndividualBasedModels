clear all

% Parameters
N = 1000; % Number of mussels
Length = 50; % Length of the Arena, in cm
EndTime = 500; % Number of minutes

% Declaring the parameters that describe movement speed
P1 = 100;
P2 = -80;
P3 = 3;
D1 = 2; % cm, mussels within this distance are considered neighbors
D2 = 6; % cm, mussels within this distance are considered
% as "within cluster distance", in cm.

% Constant and variable declaration, used below
Diagonal=diag(ones(N,1)); % Used below
Distance=zeros(N,N); % Assigning the array

% Initial conditions
X = rand(N,1)*50;
Y = rand(N,1)*50;

% Loop repeating the movement calculation for each time step
for Time=1:EndTime
    for i=1:N
        for j=1:N
        Distance(i,j)= sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
        end
    end
    % Number of mussels direct neighbors (V1) and cluster distance (V2)
    Nr_In_Dist1 = (Distance<D1)-Diagonal;
    Nr_In_Dist2 = (Distance<D2)-Diagonal;
    
    % Density
    V1 = sum(Nr_In_Dist1)/(D1.^2*pi()); % sum/surface
    V2 = sum(Nr_In_Dist2)/(D2.^2*pi()); % sum/surface

    % Step size and direction of mussels
    Beta=1./(max(0.001,P1*V1'+P2*V2')+P3);
    StepSize = -Beta .* log(rand(N,1));
    Angle = rand(N,1)*360;
    
    % Change in X and Y during tipe step = 1 min
    X = X+StepSize.*cos(Angle);
    Y = Y+StepSize.*sin(Angle);

    % Mussels in the arena or outside
    for i = 1:N
        if X(i) > Length
            X(i) = X(i)-Length;
        end
        if X(i) < 0
            X(i) = X(i)+Length;
        end
        if Y(i) > Length
            Y(i) = Y(i)-Length;
        end
        if Y(i) < 0
            Y(i) = Y(i)+Length;
        end
    end
    
    
    plot(X, Y, '.', 'MarkerSize', 15);
    title('Mussel distribution in the arena (N=2000) with inhibition blocked');
    xlabel('X (cm)');
    ylabel('Y (cm)');
    drawnow;
    
    












end
