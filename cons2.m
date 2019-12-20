function [cons2] = cons2(particle,maxtrip,numbus)
cons2 = true;
bus_position = same_bus(particle,numbus);
for i = 1:numbus
    tripset=bus_position{i,1};
    if max(size(tripset))>=2
        for k = 2:max(size(tripset))
            if rem(tripset(k)-tripset(k-1),2)==0 && k~= maxtrip+1
                cons2=false;
                return;
            end
        end
    end
end
end