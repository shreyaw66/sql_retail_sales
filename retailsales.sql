use Retail_sales;

SELECT TOP (1000) [transactions_id]
      ,[sale_date]
      ,[sale_time]
      ,[customer_id]
      ,[gender]
      ,[age]
      ,[category]
      ,[quantiy]
      ,[price_per_unit]
      ,[cogs]
      ,[total_sale]
  FROM [Retail_sales].[dbo].[RetailSales]


  SELECT * FROM RetailSales
    where transactions_id is null
  or sale_date is null
  or sale_time is null
  or customer_id is null
  or gender is null
  or category IS NUll
  or quantiy IS NUll
  or cogs IS NUll
  or total_sale IS NUll;

  DELETE FROM RetailSales
      where transactions_id is null
  or sale_date is null
  or sale_time is null
  or customer_id is null
  or gender is null
  or category IS NUll
or quantiy IS NUll
  or cogs IS NUll
  or total_sale IS NUll;


  select count(*) from RetailSales;

  --How many customers do we have


  select count(distinct customer_id) from RetailSales;

    --How many category do we have


  select distinct category from RetailSales;


  --1)Write a SQL query to retrieve all columns for sales made on '2022-11-05:

  select * from RetailSales where sale_date = '05-11-2022';

  --2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

  select * from RetailSales
  where category = 'Clothing'
   and MONTH(sale_date) = '4' and year(sale_date) ='2022'
	  and quantiy  >= 4
;

--3) Write a SQL query to calculate the total sales (total_sale) for each category.:

select category, sum(total_sale) as total_sale
from RetailSales
group by category;

--4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select category, round(AVG(age),2) as avg_age
from retailsales
where category = 'Beauty'
group by category;

--5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from retailsales where total_sale > 1000;

--6)Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select category,gender,count(transactions_id) as count_of_transaction
from retailsales
group by category,gender


--7)Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select years, 
		months,
		avg_sale 
from
(
	select year(sale_date) as years,
	month(sale_date) as months,
	avg(total_sale) as avg_sale,
	RANK() over(partition by year(sale_date) order by avg(total_sale) desc) as r
	from retailsales
	group by year(sale_date), month(sale_date)
) as t1
where r < 2


--8) **Write a SQL query to find the top 5 customers based on the highest total sales **:

select top 5 customer_id, sum(total_sale) as total_sale
from retailsales
group by customer_id
order by sum(total_sale) desc

--9) Write a SQL query to find the number of unique customers who purchased items from each category.:

select category, count(distinct customer_id) as counts
from retailsales
group by category


--10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


With CTE as
(
	select *, case when convert(varchar(8), sale_time, 108) < '12:00:00' then 'Morning'
				when convert(varchar(8), sale_time, 108) between '12:00:00' and '17:00:00'  then 'Afternoon'
				Else 'Evening'
				End as Shifts
	from retailsales
)

select shifts, count(*) as no_of_orders from CTE
group by shifts
	


