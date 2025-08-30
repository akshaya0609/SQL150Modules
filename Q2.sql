select (case when price<100 then 'Low Price'
        when price >=100 and price <=500 then 'Medium Price'
        when price>500 then 'High Price' end) as products , count(*) as prod_count from Q2
group by products
order by count(*);