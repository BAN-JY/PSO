function [cons1] = cons1(particle,maxtrip,numbus)
cons1 = true;
bus_position = same_bus(particle,numbus);
for i = 1:numbus
    tripset=bus_position{i,1};
    if max(size(tripset))>2*maxtrip
        cons1=flase;
        break;
    end
end
end