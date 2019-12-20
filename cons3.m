function [cons3] = cons3(particle,maxtrip,numbus,timetable,time_charging,time_trip,distance_charging,distance_trip,unit_distance_charging_time,probability)
cons3=true;
bus_position = same_bus(particle,numbus);
[ChargingTimeMid, ~] = charging_time(distance_charging,distance_trip,unit_distance_charging_time,maxtrip,particle,numbus);
for i = 1:numbus
    tripset = bus_position{i,1};
    if max(size(tripset))>=2
        for k=2:max(size(tripset))
            if timetable(tripset(k))< timetable(tripset(k-1))+time_trip(tripset(k-1))
                cons3=flase;
                return;
            end
            if k==maxtrip+1
                waiting_time=waiting_time(tripset(k-1),probability);
                total_time_charging=waiting_time+time_charging(2-rem(tripset(k),2))+time_charging(rem(tripset(k-1),2)+1)+ChargingTimeMid(i);
                if timetable(tripset(k))<timetable(tripset(k-1))+time_trip(tripset(k-1))+total_time_charging
                    cons3=false;
                    return;
                end
            end
        end
    end
end
end
                
                