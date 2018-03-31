--Calculate the median value in an SQL table. 

--Get row numbers and total counts from table. 
select s.id, s.value, 
row_number() over(order by s.value asc) as rownum, 
count(*) over() as cnt
into #temp
from schema..table s 
where s.condition_a = 1
and s.condition_b = 2
and s.year = 2018
;

--For odd number of rows, choose middle value. For even, average the two middle values.
if
(select avg(cnt) from #temp) % 2 = 0 -- Even number (X mod 2 = 0), average two middles.
(select avg(basePayAmount)
from #temp
where rownum in (cnt/2, (cnt + 2)/2)
)
else
(select value, -- Odd number (X mod 2 != 0), pick middle value.
from #temp
where rownum in (cnt/2,(cnt + 1) / 2)
)
;
