Create table Report_Table(
	product_id varchar primary key,
	sum_of_sales float ,
	sum_of_profit float 
	)

create or replace function update_product_report()
RETURNS trigger as $$
declare 
	sumOfSales float;
	sumOfProfit float;
	count_report int;
BEGIN
	select sum("sales") , sum("profit") into sumOfSales, sumOfProfit from sales 
	where product_id = NEW.product_id;
    
	select count(*) into count_report from Report_Table where product_id=NEW.product_id;
	if count_report = 0 THEN
	insert into Report_Table values (NEW.product_id, sumOfSales,sumOfProfit);
	else
		update Report_Table set  sum_of_sales = sumOfSales, sum_of_profit = sumOfProfit
		where  product_id=NEW.product_id;
	end if;
	REturn NEw;
END
$$ Language plpgsql

create trigger update_report_trigger
After insert  OR UPDATE on sales
for each row
execute function update_product_report()

select * from sales

select sum(sales), sum(profit) from sales where product_id = 'FUR-BO-10001798'

-- 89.424, 38.879999999999995

select * from sales order by order_line DESC
	
insert into sales(order_line,order_id,order_date,ship_date,ship_mode,customer_id,product_id,sales,quantity,discount,profit)
values(9997,'CA-2016-152156','2024-08-17','2024-08-24','Standard Class','CG-12520','OFF-PA-10002365',100,10,10,20)

	select  *from report_table

insert into sales(order_line,order_id,order_date,ship_date,ship_mode,customer_id,product_id,sales,quantity,discount,profit)
values(9998,'CA-2016-152156','2024-08-17','2024-08-24','Standard Class','CG-12520','FUR-BO-10001798',10,10,30,40)