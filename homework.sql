-- 1. List all customers who live in Texas (use JOINs)

select * from address;
select first_name, last_name, district
from customer
full join address
on customer.address_id = address.address_id and district = 'Texas'

-- 2. Get all payments above $6.99 with the Customer's Full Name

select first_name, last_name, amount, payment_id
from payment
full join customer
on customer.customer_id = payment.customer_id
where amount > 6.99
group by first_name, last_name, amount, payment_id
order by first_name;

-- 3. Show all customers names who have made payments over $175(use subqueries)
-- for singular payments, none?

select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 175
	group by customer_id
)


-- in total
select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc
);

-- 4. List all customers that live in Nepal (use the city table)

select first_name, last_name, country.country
from customer
inner join address
on customer.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on city.country_id = country.country_id and country.country = 'Nepal';

-- 5. Which staff member had the most transactions?

select first_name, last_name, rental.staff_id, count(rental.staff_id) as transactions
from rental
full join staff
on rental.staff_id = staff.staff_id
group by first_name, last_name, rental.staff_id
order by count(rental.staff_id) desc;

-- 6. How many movies of each rating are there?

select rating, count(rating)
from film
group by rating;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

select first_name, last_name, customer_id
from customer
where customer_id in(
	select customer_id
	from payment
	where amount > 6.99
);

-- 8. How many free rentals did our stores give away?

select count(amount)
from payment
where amount = 0;
