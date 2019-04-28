use sakila;
select first_name, last_name from sakila.actor;
select concat(first_name, " ", last_name) as "Actor Name" from sakila.actor;
#select * from sakila.actor;
select actor_id, first_name, last_name from sakila.actor where first_name="Joe";

select first_name, last_name from sakila.actor where last_name like "%GEN%";

select first_name, last_name from sakila.actor where last_name like "%LI%" order by last_name, first_name;

select * from country where country in ('Afghanistan', 'Bangladesh', 'China');
#add a columns into actor
ALTER TABLE sakila.actor add descriptions BLOB;

alter table actor drop descriptions;
select last_name, count(*) as num from sakila.actor group by last_name;
select last_name, count(last_name) as num from sakila.actor group by last_name having num >= 2;

#insert (first_name, last_name) values('HARPO',  'WILLIAMS') into actor where first_name ='GROUCHO' and last_name = 'WILLIAMS';
update actor set first_name = "HARPO" where first_name ='GROUCHO' and last_name = 'WILLIAMS';
# To check query
# disable SQL safe update
SET SQL_SAFE_UPDATES = 0;
update actor set first_name = "GROUPO" where first_name ="HARPO";
#show schema of address table 
show create table address;
# inner join address and staff

# * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
select s.first_name, s.last_name, a.address from staff as s inner join address  as a where s.address_id= a.address_id;

#show create table payment;
#show create table staff;
#select * from staff;
#select count(*) from payment;

#  6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.

SELECT s.first_name, s.last_name, s.staff_id, sum(p.amount)  from sakila.payment p inner join staff s where p.staff_id = s.staff_id and p.payment_date between '2005-08-00 00:00:00' and '2005-09-00 00:00:00' group by p.staff_id ;

# 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
# no difference if count(film_actor.actor_id) versus count(*) because we are just counting rolls
select f.title, count(*) as numOfActors from film as f inner join film_actor as fa  where f.film_id = fa.film_id group by f.title order by numOfActors desc;

# 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
select f.title, count(*) as NumOfCopies from film as f inner join inventory as inv where f.title like 'Hunchback Impossible' and f.film_id =  inv.film_id;

show create table sakila.language;

# 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
select cus.last_name, sum(p.amount) as totalPayment from customer as cus inner join payment as p where cus.customer_id = p.customer_id group by cus.last_name order by cus.last_name asc;

# 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
select title, language_id from film 
	where language_id = (select language_id from sakila.language where name = 'English') 
    and (title like 'K%' or title like 'Q%');
    
#  7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
select concat(first_name, " ", last_name) as Actors from actor where actor_id in
(select actor_id from film_actor where 
film_id = (select film_id from film where title = 'Alone Trip'));

#inner join practices
select concat(a.first_name, " ", a.last_name) as Actors, f.title from actor as a inner join
film_actor as fa on a.actor_id = fa.actor_id
inner join film as f on fa.film_id = f.film_id
where f.title = 'Alone Trip' ;

# 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
 select concat(cus.first_name, " ", cus.last_name) as CustomerName, cus.email as CustomerEmail from customer as cus
 inner join address as addr on  addr.address_id = cus.address_id 
 inner join city on city.city_id = addr.city_id
 inner join country  on country.country_id = city.country_id
 where country.country = 'Canada';
 
 #subquery practices
select concat(first_name, " ", last_name) as CustomerName, email from customer where address_id in 
(select address_id  from address where city_id in 
(select city_id from city where country_id = 
(select country_id from country where country = 'Canada')));#

#from customer_list view

# 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
# using view of film_list
select * from film_list where category = 'Family';

#7e. Display the most frequently rented movies in descending order.
# create a view for ease of use for now create view rentalview AS 

SELECT f.title, count(*) as NumOfRentals
	FROM film as f inner join inventory as inv on f.film_id = inv.film_id
	inner join rental as ren on inv.inventory_id = ren.inventory_id
	group by title order by NumOfRentals desc limit 10 ;
 
#select *, count(*) as NumOfRentals from rentalview group by title order by NumOfRentals desc limit 10 ;
#drop view rentalview;

# 7f. Write a query to display how much business, in dollars, each store brought in.
select total_sales, store from sales_by_store;
 
 # 7g. Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country from store s
join address a on (a.address_id = s.address_id)
join city c on (c.city_id = a.city_id)
join country co on (co.country_id = c.country_id);

select * from address;

show create view sales_by_store;
#select * from sales_by_store;

# 7h. List the top five genres in gross revenue in descending order. 
#(**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
#select cat.name as Genres, fc.category_id, i.film_id, i.inventory_id, sum(p.amount) as Revenues from payment as p 

select cat.name as Genres, sum(p.amount) as GrossRevenues from payment as p 
join rental as r on r.rental_id = p.rental_id 
join inventory as i on i.inventory_id = r.inventory_id 
join film_category as fc on fc.film_id = i.film_id
join category as cat on cat.category_id = fc.category_id 
group by fc.category_id order by GrossRevenues desc limit 5  ;

# Checks 
#where fc.category_id <= 2;
 
# 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
create view top_five_genres as 
select cat.name as Genres, sum(p.amount) as GrossRevenues from payment as p 
join rental as r on r.rental_id = p.rental_id 
join inventory as i on i.inventory_id = r.inventory_id 
join film_category as fc on fc.film_id = i.film_id
join category as cat on cat.category_id = fc.category_id 
group by fc.category_id order by GrossRevenues desc limit 5  ;

# 8b. How would you display the view that you created in 8a?
select * from top_five_genres; 

# 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
drop view top_five_genres;