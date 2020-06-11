--1. Add the required JAR files.:
ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-hcatalog-core-1.1.0-cdh5.11.2.jar;
SET hive.exec.max.dynamic.partitions=100000;
SET hive.exec.max.dynamic.partitions.pernode=100000;

--2. Create an External Table with 
create external table if not exists grp_task_nyc_taxi_data(
vendorid string,
tpep_pickup_datetime timestamp,
tpep_dropoff_datetime timestamp,
passenger_count int,
trip_distance double,
RatecodeID string,
store_forward_flag string,
PULocationID string, 
DOLocationID string,
payment_type string,
fare_amount double, 
extra double, 
mta_tax double, 
tip_amount double, 
tolls_charge double,
improvement_surcharge double, 
total_amount double
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
location'/common_folder/nyc_taxi_data/'
tblproperties ("skip.header.line.count"="2");

-- Basic Exploration on the dataset
select * from grp_task_nyc_taxi_data;
-- Total number of rows at first which is --1174568
select count(*) from grp_task_nyc_taxi_data;