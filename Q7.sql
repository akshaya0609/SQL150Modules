SELECT host_id, round(avg(rating),2) as avrg from  listings l
join reviews r on l.listing_id=r.listing_id
group by host_id
having count(distinct l.listing_id)>=2
order by avrg desc
limit 2;