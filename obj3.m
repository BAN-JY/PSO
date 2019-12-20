function [charging_cost] = obj3(ChargingingTimeMid,ChargingTimeNight,battery_cost)
numbus = max(size(ChargingingTimeMid));
numcharging = 0;
for i = 1:numbus
    if ChargingTimeMid>0
        numcharging = numcharging+1;
    end
    if ChargingTimeNight>0
        numcharging = numcharging+1;
    end
end
charging_cost = numcharging* battery_cost;
end