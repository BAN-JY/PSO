# Particle Swarm Optimization (PSO)
Vehicle scheduling optimization of battery electric bus based on Partical Swarm Optimization

## Introduction
&emsp;&emsp; With the development of our society, more and more people choose public transport as their first choice for traveling because of environment friendly. And battery-electric buses are seen as a well-suited technology for the electrification of road-based public transport. However, the transition process from conventional diesel to electric buses faces major hurdles caused by range limitations and the required charging time of battery buses.
&emsp;&emsp; So, how to optimize the vehicle scheduling of Battery Electric Buses needs to be studied. In my research, the optimization object including minimizing the total number of buses in operation within a day, minimizing charging cost and minimizing the battery cost.
&emsp;&emsp; This research includes maintaining the health of batter, scheduling of electric buses and optimization of the charging process. In the paper, I choose two Battery Electric Buses lines which the data is from Shanghai Bus No. 3 Bus company for research. Based on the model I purposed and the Particle Swarm Optimization algorithm, I got optimization results with less use of buses and less charging time within a day. Last, I drew a Gantt chart of the battery-electric bus scheduling.

## main_function.m
&emsp;&emsp; Code of Partical Swarm Optimization Algorithm

## Objective function

### obj1.m
&emsp;&emsp; Objective 1: To minimize the total cost of vehicle ownership.

### obj2.m
&emsp;&emsp; Objective 2: To minimize the total charging fee cost.

### obj3.m
&emsp;&emsp; Objective 3: To minimize the charging infrastructure cost.

## Constraint

### cons1.m
&emsp;&emsp; Constraint 1: Each bus can only cover 2 times maximum trips in order to balance the usage count of each bus.

### cons2.m
&emsp;&emsp; Constraint 2: The continuous trip must be the up trip to down trip or down trip to up trip.

### cons3.m
&emsp;&emsp; Constraint 3: Energy consumption constraint.
