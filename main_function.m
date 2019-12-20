clc;
clear;
close all;
%% Definition of question

nVar=238; % number of vehicles
VarSize=[1 nVar]; % Matrix of decision variable
VarMin=1; % minimum number of using vehicles
VarMax=38; % maximum number of using vehicles

%% PSO parameter

nPop=1000; % number of particle swarm
MaxIt=1000; % number of iterations
w=1; % inertia weight
wdamp=0.99; % Damping ratio
c1=1.5; % cognitive parameter
c2=2; % social parameter
% velocity limitaion
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;

%% Read data
load data
% initialization
empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
particle=repmat(empty_particle,nPop,1);
for i=1:nPop
    particle(i).Velocity=zeros(VarSize);% initial velocity
tic
    particle(i).Position=floor(unifrnd(VarMin,VarMax,VarSize));
    cons1=cons1(particle(i).Position,maxtrip,numbus);
    cons2=cons2(particle(i).Position,maxtrip,numbus);
    cons3=cons3(particle(i).Position,maxtrip,numbus,timetable_t,time_charging,time_trip,distance_charging,distance_trip,unit_distance_charging_time,probability);
    while cons1==0 || cons2==0 || cons3==0
        particle(i).Position=floor(unifrnd(VarMin,VarMax,VarSize));
        cons1=cons1(particle(i).Position,maxtrip,numbus);
        con2=cons2(particle(i).Position,maxtrip,numbus);
        cons3=cons3(particle(i).Position,maxtrip,numbus,timetable_t,time_charging,time_trip,distance_charging,distance_trip,unit_distance_charging_time,probability);
    end
    toc
    particle(i).Position=floor(unifrnd(VarMin,VarMax,VarSize)); % initial position
    particle(i).Cost=CostFunction(particle(i).Position);% initial adaptive function
    particle(i).Best.Position=particle(i).Position; % update personal best known position of particle i
    particle(i).Best.Cost=particle(i).Cost; %update personal best adaption of particle i
    if particle(i).Best.Cost<GlobalBest.Cost %update global best
        GlobalBest=particle(i).Best;
    end
end
BestCost=zeros(MaxIt,1);
%% PSO Main Loop
for it=1:MaxIt
    for i=i:nPop
        % update velocity
        particle(i).Velocity = w*particle(i).Velocity ...
                               +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
                               +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        % apply velocity limitaion
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        % update position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        %Velocity Mirror Effect
        IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
        % apply position limitation
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        particle(i).Position=floor(particle(i).Position);
        % value of adaptive function
        if cons1(particle(i).Position,maxtrip,numbus) == 0
            particle(i).Cost= 5000*maxobjfunc;
        elseif cons2(particle(i).Position,maxtrip,numbus) == 0	
            particle(i).Cost= 5000*maxobjfunc;
        elseif cons3(particle(i).Position,maxtrip,numbus,timetable,time_charging,time_trip,distance_charging,distance_trip,unit_distance_charging_time,probability)==0
            particle(i).Cost= 5000*maxobjfunc;
        else
            particle(i).Cost=objfunc(particle(i).Position,vehicle_price,numbus,power_price,distance_charging,distance_trip,unit_distance_charging_time,maxtrip,battery_cost,weight);
        end
        
        % update personal best
        if particle(i).Cost<particle(i).Best.Cost
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            % update global best
            if particle(i).Best.Cost<GlobalBest.Cost
                GlobalBest=particle(i).Best;
            end
        end
    end
    BestCost(it)=GlobalBest.Cost;
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    w=w*wdamp;
end
BestSol = GlobalBest;
%% result
figure;
%plot(BestCost,'LineWidth',2);
semilogy(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
    
    
    














