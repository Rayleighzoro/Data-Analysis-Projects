# Python

### Data Loading and Initial Cleaning:

- Load `orders.csv`, `order_details.csv`, `pizzas.csv`, and `pizza_types.csv` into pandas DataFrames.
- Inspect data types, identify and handle missing values, and convert `date` and `time` columns in `orders` to appropriate datetime formats.
- Standardize `pizza_id` columns across relevant DataFrames for consistent merging (e.g., handling casing or extra spaces).
- Sales Trends and Top-Selling Analysis:

### Merge all four DataFrames into a single comprehensive DataFrame.
- Calculate a `total_price` column for each pizza item in the merged DataFrame (`quantity * price`).
- Analyze and visualize the **cumulative revenue generated over time** (e.g., a line chart showing running total of daily revenue).
- Identify the **top 5 most ordered pizza** types along with their total quantities from the merged data.
- Determine the **top 3 most ordered pizza types based on total revenue** from the merged data.


# SQL 

### Basic:

- **Total Orders**: Retrieve the total number of orders placed.
- **Total Revenue**: Calculate the total revenue generated from all pizza sales.
- **Highest-Priced Pizza**: Identify the name of the highest-priced pizza.
- **Most Common Pizza Size**: Identify the most commonly ordered pizza size.
- **Most Common Pizza types**: List the top 5 most ordered pizza types along with their quantities.


### Intermediate:

- **Pizza Category Quantity**: Find the total quantity of each pizza category ordered.
- **Orders by Hour**: Determine the distribution of orders by hour of the day.
- **Category-wise Pizza Distribution**: Find the number of unique pizzas (from the pizzas table) that belong to each category.
- **Average Pizzas Per Day**: Group the orders by date and calculate the average number of pizzas ordered per day.
- **Most pizza ordered**: Determine the top 3 most ordered pizza types based on revenue.


### Advanced:
- **Percentage Contribution to Revenue**: Calculate the percentage contribution of each pizza type to the total revenue.
- **Revenue generated over time**: Analyze the cumulative revenue generated over time.
- **Top 3 Pizza Types by Revenue per Category**: Determine the top 3 most ordered pizza types (by revenue) for each distinct pizza category.
