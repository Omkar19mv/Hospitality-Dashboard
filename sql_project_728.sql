use PROJECT_HOSPITALITY;

-----1.total_revenue-----;

select booking_status,revenue_realized as total_revenue from fact_bookings;

select sum(revenue_realized) as total_revenue,booking_status from fact_bookings where booking_status = "Checked Out";


-----2.occupancy-------;

select * from fact_aggregated_bookings;

select successful_bookings,capacity,sum(successful_bookings)/sum(capacity)*100 as occupancy_rate from fact_aggregated_bookings group by successful_bookings,capacity;

----3.cancellation_rate-----;

select * from fact_bookings; 

select round((sum(case when booking_status = "cancelled" then 1 else 0 end)*100/ count(*)),2) as "Cancellation_Rate(%)" from fact_bookings;

------4.total_booking------;

select * from fact_bookings;

select booking_status,count(booking_status) as total_bookings from fact_bookings where booking_status = "Checked out" group by booking_status;

------5.utilized_capacity------;

 select * from fact_aggregated_bookings;
 
 select sum(capacity) as UtilizeCapacity from fact_aggregated_bookings;
 
 -------6.trend_analysis-----;
 
select dim_hotel.city,sum(fact_bookings.revenue_generated) as total_revenue,sum(fact_bookings.revenue_realized) as revenue_realized
from dim_hotel join fact_bookings
on dim_hotel.property_id=fact_bookings.property_id
group by dim_hotel.city;


-------7.weekend/weekday revenue--------;
select dim_date.day_type, sum(fact_bookings.revenue_realized) AS TotalRevenue,count(fact_bookings.booking_id) AS TotalBookings
from dim_date join
fact_bookings on fact_bookings.check_in_date
group by dim_date.day_type;


------8.-----Revenue by City & hotel----;
select  dim_hotel.city,dim_hotel.property_name as Property,sum(fact_bookings.revenue_realized) as TotalRevenue
from fact_bookings join dim_hotel
on  fact_bookings.property_id=dim_hotel.property_id
group by dim_hotel.city,dim_hotel.property_name
order by TotalRevenue desc;

-----9.Class Wise Revenue------;
select dim_rooms.room_class as RoomClass ,sum(fact_bookings.revenue_realized) as TotalRevenue
from dim_rooms join fact_bookings
on dim_rooms.room_id=fact_bookings.room_category
group by dim_rooms.room_class;

-------10.Checked_out_cancel_No_show--------;
select booking_status,count(*) as BookingStatusCount from fact_bookings
where booking_status in ('Checked Out', 'Cancelled', 'No Show') 
group by booking_status;


------11.Weekly trend Key trend (Revenue, Total booking, Occupancy)------; 

