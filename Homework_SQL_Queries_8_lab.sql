#Rank films by length (filter out the rows with nulls or zeros in length column). 
#Select only columns title, length and rank in your output.

select title,length, rank () over( order by length ) as 'rank'
from film;

#Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
#In your output, only select the columns title, length, rating and rank.

select title, length , rating , dense_rank () over(partition by rating order by length ) as 'rank'
from film;

#How many films are there for each of the categories in the category table? 
#Hint: Use appropriate join between the tables "category" and "film_category".

select category.name, count(film_category.film_id)
from film_category
join category on category.category_id=film_category.category_id
group by category.name;

#Which actor has appeared in the most films? 
#Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select * from actor;

select actor.last_name,count(film_actor.film_id)
from actor
join film_actor on film_actor.actor_id=actor.actor_id
group by actor.last_name
order by 2 desc;

#Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" 
#and count the rental_id for each customer.

select customer.last_name,count(rental.rental_id)
from customer
join rental on rental.customer_id=customer.customer_id
group by customer.last_name
order by 2 desc;

#Which is the most rented film? (The answer is Bucket Brotherhood).

select film.title, count(rental.rental_id)
from film
inner join inventory on inventory.film_id=film.film_id
inner join rental on rental.inventory_id=inventory.inventory_id
group by film.title
having count(rental.rental_id)=
(select max(rent_film.count_rent_film)
from (select i.film_id, count(R.rental_id) as count_rent_film
from rental R
inner join inventory i on i.inventory_id=r.inventory_id
group by i.film_id) rent_film);

     
