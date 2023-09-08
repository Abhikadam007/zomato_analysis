use zomato;

select * from zomato1;
SELECT * FROM Country;

-- 3.Find the Numbers of Resturants based on City and Country.
select c.cname,z.city,count(z.RestaurantID)
 from zomato1 as z
 join Country as c
 on z.CountryCode=c.CountryCode
 group by cname,city
 ;

select c.cname,z.city,count(z.RestaurantID) as No_restaurant
 from zomato1 as z
 join Country as c
 on z.CountryCode=c.CountryCode
 where c.cname="USA"
 group by cname,city
 ;
 
 -- 4.Numbers of Resturants opening based on Year , Quarter , Month,Day
select count(restaurantid) as No_Of_Restaurants,year(datekey) as Year,concat("Q",(quarter(datekey))) as Quarter,month(datekey) as Month,dayname(datekey) as Day
from zomato1
group by Year, Quarter,Month
order by Year;

 
-- 5. Count of Resturants based on Average Ratings

select count(restaurantID) as No_of_Restaurants,avg(rating) as AverageRating from zomato1
group by Rating
order by AverageRating;

-- ------------------------------------------------------------------------------------------------------------------------
-- Top 10 City with NOrthIndin Cuisine
select city,count(*) as No_of_Restaurant 
from zomato1
where cuisine="North Indian"
group by city
order by No_of_Restaurant desc
limit 10 ;
-----------------------------------------------------------------------------------------------------------
-- 6. Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
select
case
 when Average_cost_for_two <=500 then '0-500'
 when Average_cost_for_two > 500 and Average_cost_for_two <=1000 then '501-1000'
 when Average_cost_for_two > 1000 and Average_cost_for_two <=1500 then '1001-1500'
 when Average_cost_for_two > 1500 and Average_cost_for_two <=2000 then '1501-2000'
 when Average_cost_for_two > 2000 and Average_cost_for_two <=2500 then '2001-2500'
 else '2500+'
end as buckets,
count(*) as No_of_Restaurants from zomato1
group by buckets;

-- Make a Ratings buckets
select
case
 when Rating <=1 then '0-1'
 when Rating > 1 and rating <=2 then '1-2'
 when Rating > 2 and rating <=3 then '2-3'
 when Rating > 3 and rating <=4 then '3-4'
 when Rating > 4 and rating <=4.5 then '4-4.5'
 else '4.5+'
end as Ratings,
count(*) as No_of_Restaurants from zomato1
group by Ratings
order by Ratings;

-- Count of restaurants based on Cuisines with indian city
select c.cname, z.city,z.cuisine,count(z.restaurantid) as No_of_Restaurants  from zomato1 as z
join country as c
on z.countrycode=c.countrycode
group by c.cname, z.city,z.cuisine
order by No_of_restaurants desc
;

-- -- Count of restaurants based on Cuisines except indian city
select c.cname, z.city,z.cuisine,count(z.restaurantid) as No_of_Restaurants  from zomato1 as z
join country as c
on z.countrycode=c.countrycode
where c.cname <> 'India'
group by c.cname, z.city,z.cuisine
order by No_of_restaurants desc
;

-- Based on Price Range with india
select c.cname as Country , z.City as City, z.price_range as PriceRange , count(*) as No_Of_Restaurants from zomato1 as z
join country as c
on c.countrycode=z.countrycode
group by Country,City,PriceRange
order by PriceRange asc , No_Of_Restaurants desc;

-- only india
select c.cname as Country , z.City as City,z.price_range as PriceRange , count(*) as No_Of_Restaurants 
from zomato1 as z
join country as c
on c.countrycode=z.countrycode
where c.cname='India'
group by Country,City,PriceRange
order by PriceRange asc,No_Of_Restaurants desc;

-- 7.Percentage of Resturants based on "Has_Table_booking"
select Has_Table_Booking,count(*) as No_of_Restaurants,
round(count(restaurantid)/sum( count(restaurantid)) over() * 100,2) as Percentage
from zomato1
group by Has_Table_Booking
order by No_of_restaurants desc;

-- only india
select Has_Table_Booking,count(*) as No_of_Restaurants,
round(count(restaurantid)/sum( count(restaurantid)) over() * 100,2) as Percentage
from zomato1
where countrycode=1
group by Has_Table_Booking
order by No_of_restaurants desc;


-- 8.Percentage of Resturants based on "Has_Online_Delivery"
select Has_online_delivery,count(*) as No_of_Restaurants,
round(count(restaurantid)/sum( count(restaurantid)) over() * 100,2) as Percentage
from zomato1
group by Has_online_delivery
order by No_of_restaurants desc;

-- only india
select Has_online_delivery,count(*) as No_of_Restaurants,
round(count(restaurantid)/sum( count(restaurantid)) over() * 100,2) as Percentage
from zomato1
where countrycode=1
group by Has_online_delivery
order by No_of_restaurants desc;


-- 9.Percentage of Resturants based on "IS_Delievery_Now"
select IS_Delievery_Now,count(*) as No_of_Restaurants,
round(count(restaurantid)/sum( count(restaurantid)) over() * 100,2) as Percentage
from zomato1
group by IS_Delievery_Now
order by No_of_restaurants desc;

select IS_Delievery_Now,count(*) as No_of_Restaurants,
round(count(restaurantid)/sum( count(restaurantid)) over() * 100,2) as Percentage
from zomato1
where countrycode=1
group by IS_Delievery_Now
order by No_of_restaurants desc;


