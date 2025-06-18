-- BASIC
-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    Pizza_Sales.orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(order_details.quantity) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY 1
ORDER BY 2 DESC; 

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(Order_time) AS hours, COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY 1;


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    Category, COUNT(name)
FROM
    pizza_types
GROUP BY Category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(total_orders), 2) as avg_number_of_pizzas
FROM
    (SELECT 
        Orders.Order_date,
            SUM(order_details.quantity) AS total_orders
    FROM
        Orders
    JOIN order_details ON Orders.order_id = order_details.order_id
    GROUP BY 1) AS avg_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category,
    round(sum(order_details.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS total_revenue
        FROM
            order_details
                JOIN
            pizzas ON order_details.pizza_id = pizzas.pizza_id)* 100,2) AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY 1;

-- Analyze the cumulative revenue generated over time.
select Order_date, sum(revenue) over(order by Order_date) as cum_revenue
from (SELECT Orders.Order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas on order_details.pizza_id = pizzas.pizza_id
join Orders on Orders.Order_id = order_details.order_id
group by 1) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT Category, name, revenue
from 
(select category, name, revenue, 
rank() over(partition by category order by revenue desc) as rn
from 
(SELECT 
    pizza_types.category,
    pizza_types.name,
    SUM((order_details.quantity) * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 1 , 2) as a) as b
where rn <= 3 ;
