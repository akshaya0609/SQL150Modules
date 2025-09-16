SELECT DATE_SUB(DATE(now()), 
INTERVAL case when DAYOFWEEK(now())=1 then 7 else DAYOFWEEK(now())-1 end DAY) as last_sunday;