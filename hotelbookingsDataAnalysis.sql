select * from employee.dbo.[hotel_bookings 2]

--count cancel room of City hotel
select hotel, count(is_canceled) as CanceledRoom1 
from employee.dbo.[hotel_bookings 2]
where hotel = 'City Hotel'
group by hotel

--count cancel room of Resort hotel
select hotel, COUNT(is_canceled) as CanceledRoom2
from employee.dbo.[hotel_bookings 2]
where hotel = 'Resort Hotel'
group by hotel

--Average cancellation of city hotel
select hotel,AVG(cast(is_canceled as float)*100)AverageCancelation 
from employee.dbo.[hotel_bookings 2]
where hotel = 'City hotel'
group by hotel

--Average cancellation of resort hotel
select hotel,Avg(cast(is_canceled as float)*100)AverageCancelation
from employee.dbo.[hotel_bookings 2]
where hotel = 'Resort Hotel'
group by hotel

--Average cancellation of Both hotel 
select hotel, AVG(cast(is_canceled as float)*100)AverageofCancellation 
from employee.dbo.[hotel_bookings 2]
where hotel in('City Hotel' , 'Resort Hotel')
group by hotel

--is canceled room hotel
select count(*) from employee.dbo.[hotel_bookings 2]
where is_canceled=1

--is not canceled room hotel
select COUNT(*) from employee.dbo.[hotel_bookings 2]
where is_canceled=0

--Total cancel room of city hotel
select count(*)as cancelRoomofCityHotel from employee.dbo.[hotel_bookings 2]
where is_canceled=1 and hotel='City Hotel'

--Total cancel room of resort hotel
select count(*)as cancelRoomofResortHotel from employee.dbo.[hotel_bookings 2]
where is_canceled=1 and hotel='Resort Hotel'

--both of total cancelation room
select hotel,is_canceled,count(*)as CancelRoomofHotel
from employee.dbo.[hotel_bookings 2]
where is_canceled=1 and (hotel='City Hotel' OR hotel='Resort Hotel')
group by hotel,is_canceled

--Cancellation Date of city hotel
select hotel,reservation_status_date,COUNT(reservation_status) as CancelRoom
from employee.dbo.[hotel_bookings 2]
where reservation_status='Canceled' And hotel='City Hotel'
group by hotel,reservation_status_date
order by reservation_status_date

--Cancellation Date of city hotel
select hotel,reservation_status_date,COUNT(reservation_status) as CancelRoom
from employee.dbo.[hotel_bookings 2]
where reservation_status='Canceled' And hotel='Resort Hotel'
group by hotel,reservation_status_date
order by reservation_status_date

--Cancel offline room date
select hotel,reservation_status_date,reservation_status,
case market_segment 
	 when 'Online TA' then 'Online TA'
else 'offline'
	  end cancel
from employee.dbo.[hotel_bookings 2]
where reservation_status='Canceled'
order by reservation_status_date,reservation_status

--Total canceled adr of City hotel
select hotel,reservation_status,count(adr) as CancelAdrOfCityHotel
from employee.dbo.[hotel_bookings 2]
where reservation_status='Canceled' And hotel='City Hotel'
group by hotel,reservation_status
having count(adr) > 5

--Total canceled adr of Resort hotel
select hotel,reservation_status,count(adr) as CancelAdrOfCityHotel
from employee.dbo.[hotel_bookings 2]
where reservation_status='Canceled' And hotel='Resort Hotel'
group by hotel,reservation_status
having count(adr) > 5

--Both of canceled adr 
select hotel,reservation_status,count(adr) as TotalCanceladr
from employee.dbo.[hotel_bookings 2]
where reservation_status='Canceled' And (hotel='City hotel' or hotel= 'Resort Hotel')
group by hotel,reservation_status
having count(adr) > 5

--find country cancelation of city hotel
select hotel,country,reservation_status_date,reservation_status
 from employee.dbo.[hotel_bookings 2]
 where reservation_status='Canceled' and hotel='City Hotel'
 order by country

 --find country cancelation of Resort hotel
 select hotel,country,reservation_status_date,reservation_status
 from employee.dbo.[hotel_bookings 2]
 where reservation_status='Canceled' and hotel='City Hotel'
 order by country,reservation_status_date

