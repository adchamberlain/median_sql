--Calculate the median value in an SQL table. 

--Get row numbers and total counts from table. 
SELECT s.id, s.value, 
    ROW_NUMBER() OVER(ORDER BY s.value ASC) AS rownum, 
    COUNT(*) OVER() AS cnt
INTO #temp
FROM schema..table s 
WHERE s.condition_a = 1
    AND s.condition_b = 2
    AND s.year = 2018;

--Determine median based on count being odd or even
DECLARE @cnt INT = (SELECT TOP 1 cnt FROM #temp);

IF @cnt % 2 = 0 
BEGIN
    -- Even number of rows: average the two middle values
    SELECT AVG(value) AS median
    FROM #temp
    WHERE rownum IN (@cnt/2, (@cnt/2)+1);
END
ELSE
BEGIN
    -- Odd number of rows: select the middle value
    SELECT value AS median
    FROM #temp
    WHERE rownum = (@cnt+1)/2;
END

-- Clean up
DROP TABLE #temp;
