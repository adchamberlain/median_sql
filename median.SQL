--Find the median salary. Table name is table, column name is salary.

with ranked_salaries as (
select 
  salary,
  row_number() over (order by salary) as row_num,
  count(*) over () as total_rows
from table)

select  
  case
    when total_rows % 2 = 1 then -- odd number of rows
      (select salary from ranked_salaries where row_num = (total_rows + 1)/2)
    else -- even number of rows
      (select avg(salary) 
       from ranked_salaries 
       where row_num in (total_rows/2, total_rows/2 + 1))
  end as median_salary
from ranked_salaries
limit 1;
