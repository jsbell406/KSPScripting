set gravAcc to (constant:G * ship:body:mass) / (ship:body:radius ^ 2).
set gravAcc1 to (constant:G * ship:body:mass) / ((ship:body:radius + altitude) ^ 2).

declare global TWR to ((ship:availablethrust * gravAcc) / (mass * gravAcc ^ 2)) * throttle.
declare global actTWR to ((ship:availablethrust * gravAcc1) / (mass * gravAcc1 ^ 2)) * throttle.
declare global maxTWR to (ship:availablethrust * gravAcc1) / (mass * gravAcc1 ^ 2).