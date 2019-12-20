function [vehicle_cost] = obj1(particle,vehicle_price,numbus)
bus_position = same_bus(particle,numbus);
n= 0;
for i = 1:numbus
    if isempty(bus_position{i,1})==0
        n=n+1;
    end
end
vehicle_cost=n*vehicle_price;
end
