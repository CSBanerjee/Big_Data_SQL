
-- creating schema----
create schema Assignment;
 -- use schema
use Assignment;
-- import all the csv files by 'Table Data Import Wizard' on user interface  
select * from assignment.bajaj_auto;
-- check the datatype of imported columns
describe assignment.bajaj_auto date;
describe assignment.bajaj_auto `Close Price`;
-- We can see the date column is not correctly imported and present in the table as text datatype. Hence we need to
-- change the data type to date format
create table bajaj1 as
(
SELECT STR_TO_DATE(Date, "%d-%M-%Y") as Date,`Close Price` from assignment.bajaj_auto
order by Date)
 ;
 -- Now check the date column of bajaj1 table
describe assignment.bajaj1 date;
Drop table bajaj_auto;
select * from assignment.bajaj1;
-- Similarly create all other companies close price tables
create table Eicher1 as
(
SELECT STR_TO_DATE(Date, "%d-%M-%Y") as Date,`Close Price` from assignment.eicher_motors
order by Date)
 ;
select * from Eicher1;
Drop table assignment.eicher_motors;
-- ----------------------------------------------
create table Hero1 as
(
SELECT STR_TO_DATE(Date, "%d-%M-%Y") as Date,`Close Price` from assignment.hero_motocorp
order by Date)
 ;
select * from Hero1;
Drop table assignment.hero_motocorp;
-- -----------------------------------------------
create table infosys1 as
(

SELECT STR_TO_DATE(Date, "%d-%M-%Y") as Date,`Close Price` from assignment.infosys
order by Date)
 ;
select * from infosys1;
Drop table assignment.infosys;
-- ------------------------------------------------
create table tcs1 as
(
SELECT STR_TO_DATE(Date, "%d-%M-%Y") as Date,`Close Price` from assignment.tcs
order by Date)
 ;
select * from tcs1;
Drop table assignment.tcs;
-- ---------------------------------------------
create table tvs1 as
(
SELECT STR_TO_DATE(Date, "%d-%M-%Y") as Date,`Close Price` from assignment.tvs_motors
order by Date)
 ;
select * from tvs1;
Drop table assignment.tvs_motors;
-- ----------------------------------------------
-- Qusestion No 1.
-- Create 20 day and 50 day moving average columns in bajaj1 table
create table tbl1 as (
select *, avg(`Close Price`) over (order by Date rows 19 preceding) 20_Day_MA,
avg(`Close Price`) over (order by Date rows 49 preceding) 50_Day_MA
from bajaj1);
drop table bajaj1;
rename table tbl1 to bajaj1;
select * from bajaj1;
-- --------------------------------------------
create table tbl1 as (
select *, avg(`Close Price`) over (order by Date rows 19 preceding) 20_Day_MA,
avg(`Close Price`) over (order by Date rows 49 preceding) 50_Day_MA
from eicher1);
drop table eicher1;
rename table tbl1 to eicher1;
select * from eicher1;
-- --------------------------------------------
create table tbl1 as (
select *, avg(`Close Price`) over (order by Date rows 19 preceding) 20_Day_MA,
avg(`Close Price`) over (order by Date rows 49 preceding) 50_Day_MA
from hero1);
drop table hero1;
rename table tbl1 to hero1;
select * from hero1;
-- --------------------------------------------
create table tbl1 as (
select *, avg(`Close Price`) over (order by Date rows 19 preceding) 20_Day_MA,
avg(`Close Price`) over (order by Date rows 49 preceding) 50_Day_MA
from infosys1);
drop table infosys1;
rename table tbl1 to infosys1;
select * from infosys1;
-- --------------------------------------------
create table tbl1 as (
select *, avg(`Close Price`) over (order by Date rows 19 preceding) 20_Day_MA,
avg(`Close Price`) over (order by Date rows 49 preceding) 50_Day_MA
from tcs1);
drop table tcs1;
rename table tbl1 to tcs1;
select * from tcs1;
-- --------------------------------------------
create table tbl1 as (
select *, avg(`Close Price`) over (order by Date rows 19 preceding) 20_Day_MA,
avg(`Close Price`) over (order by Date rows 49 preceding) 50_Day_MA
from tvs1);
drop table tvs1;
rename table tbl1 to tvs1;
select * from tvs1;
-- ------------------------------------------
-- Question Number 2
create table master as (
select a.Date,a.`Close Price` as Bajaj,b.`Close Price` as TCS, c.`Close Price` as TVS,
d.`Close Price` as Infosys,e.`Close Price` as Eicher,f.`Close Price` as Hero from bajaj1 a
left join tcs1 b using(date)
left join tvs1 c using(date)
left join infosys1 d using(date)
left join Eicher1 e using(date)
left join hero1 f using(date));
select * from master;
-- ------------------------------------------
-- Question Number 3
create table bajaj2 (
with tbl1 as 
(
select *, case when (rank() over (order by date ))<=20 
then null else 20_Day_MA end as 20_Day_MA_Lag from bajaj1),
tbl2 as
(
select a.*,(20_Day_MA_Lag-50_Day_MA) diff from tbl1 a
),
tbl3 as
(
select a.*,lead(diff,1) over ( order by date) as diff_Lead from tbl2 a
),
tbl4 as
(
select a.*,(case when (sign(diff)=sign(diff_Lead)) or (diff_Lead is null) then 'Hold'
when sign(diff_Lead)=-1 then 'Sell' else 'Buy' end) as `Signal` from tbl3 a
)
select Date,`Close Price`,`Signal` from tbl4
);
select * from bajaj2;
-- -------------------------------------------
create table eicher2 (
with tbl1 as 
(
select *, case when (rank() over (order by date ))<=20 
then null else 20_Day_MA end as 20_Day_MA_Lag from eicher1),
tbl2 as
(
select a.*,(20_Day_MA_Lag-50_Day_MA) diff from tbl1 a
),
tbl3 as
(
select a.*,lead(diff,1) over ( order by date) as diff_Lead from tbl2 a
),
tbl4 as
(
select a.*,(case when (sign(diff)=sign(diff_Lead)) or (diff_Lead is null) then 'Hold'
when sign(diff_Lead)=-1 then 'Sell' else 'Buy' end) as `Signal` from tbl3 a
)
select Date,`Close Price`,`Signal` from tbl4
);
select * from eicher2;
-- -------------------------------------
create table hero2 (
with tbl1 as 
(
select *, case when (rank() over (order by date ))<=20 
then null else 20_Day_MA end as 20_Day_MA_Lag from hero1),
tbl2 as
(
select a.*,(20_Day_MA_Lag-50_Day_MA) diff from tbl1 a
),
tbl3 as
(
select a.*,lead(diff,1) over ( order by date) as diff_Lead from tbl2 a
),
tbl4 as
(
select a.*,(case when (sign(diff)=sign(diff_Lead)) or (diff_Lead is null) then 'Hold'
when sign(diff_Lead)=-1 then 'Sell' else 'Buy' end) as `Signal` from tbl3 a
)
select Date,`Close Price`,`Signal` from tbl4
);
select * from hero2;
-- -------------------------------------
create table infosys2 (
with tbl1 as 
(
select *, case when (rank() over (order by date ))<=20 
then null else 20_Day_MA end as 20_Day_MA_Lag from infosys1),
tbl2 as
(
select a.*,(20_Day_MA_Lag-50_Day_MA) diff from tbl1 a
),
tbl3 as
(
select a.*,lead(diff,1) over ( order by date) as diff_Lead from tbl2 a
),
tbl4 as
(
select a.*,(case when (sign(diff)=sign(diff_Lead)) or (diff_Lead is null) then 'Hold'
when sign(diff_Lead)=-1 then 'Sell' else 'Buy' end) as `Signal` from tbl3 a
)
select Date,`Close Price`,`Signal` from tbl4
);
select * from infosys2;
-- -------------------------------------
create table tcs2 (
with tbl1 as 
(
select *, case when (rank() over (order by date ))<=20 
then null else 20_Day_MA end as 20_Day_MA_Lag from tcs1),
tbl2 as
(
select a.*,(20_Day_MA_Lag-50_Day_MA) diff from tbl1 a
),
tbl3 as
(
select a.*,lead(diff,1) over ( order by date) as diff_Lead from tbl2 a
),
tbl4 as
(
select a.*,(case when (sign(diff)=sign(diff_Lead)) or (diff_Lead is null) then 'Hold'
when sign(diff_Lead)=-1 then 'Sell' else 'Buy' end) as `Signal` from tbl3 a
)
select Date,`Close Price`,`Signal` from tbl4
);
select * from tcs2;
-- -------------------------------------
create table tvs2 (
with tbl1 as 
(
select *, case when (rank() over (order by date ))<=20 
then null else 20_Day_MA end as 20_Day_MA_Lag from tvs1),
tbl2 as
(
select a.*,(20_Day_MA_Lag-50_Day_MA) diff from tbl1 a
),
tbl3 as
(
select a.*,lead(diff,1) over ( order by date) as diff_Lead from tbl2 a
),
tbl4 as
(
select a.*,(case when (sign(diff)=sign(diff_Lead)) or (diff_Lead is null) then 'Hold'
when sign(diff_Lead)=-1 then 'Sell' else 'Buy' end) as `Signal` from tbl3 a
)
select Date,`Close Price`,`Signal` from tbl4
);
select * from tvs2;
-- ---------------------------------------
-- Question Number 4

delimiter $$
create function Signal_Bajaj(user_date date) 
returns varchar(20) 
deterministic
begin   
  declare output_signal varchar(20);
  select bajaj2.signal into output_signal from bajaj2 
  where date = user_date;
  return output_signal ;
  end
 $$ delimiter ;
select Signal_Bajaj('2015-01-29') as Signal_Output;


----------------------------------------------------------
