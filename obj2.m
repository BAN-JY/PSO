function [power_cost] = obj2(ChargingTimeMid, ChargingTimeNight, power_price)
power_cost = sum(ChargingTimeMid(:))*max(power_price)+ sum(ChargingTimeNight(:))*min(power_price);
end