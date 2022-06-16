CREATE TABLE menu(
    product_id INT,
    product_name VARCHAR(10),
    price INT,
    PRIMARY KEY (product_id)
);

CREATE TABLE members (
    customer_id VARCHAR(1),
    join_date DATE,
    PRIMARY KEY(customer_id) 
);

CREATE TABLE sales (
    customer_id VARCHAR (1),
    order_date DATE,
    product_id INT,
    order_no INT, 
    PRIMARY KEY (order_no),
    FOREIGN KEY (customer_id) REFERENCES members(customer_id),
    FOREIGN KEY (product_id) REFERENCES menu(product_id)
);

INSERT INTO members VALUES ("A", "2021-01-07");
INSERT INTO members VALUES ("B", "2021-01-09");
INSERT INTO members VALUES ("C", NULL);

INSERT INTO menu VALUES (1, "sushi", 10);
INSERT INTO menu VALUES (2, "curry", 15);
INSERT INTO menu VALUES (3, "ramen", 12);

INSERT INTO sales VALUES ("A", "2021-01-01", 1, 1);
INSERT INTO sales VALUES ("A", "2021-01-01", 2, 2);
INSERT INTO sales VALUES ("A", "2021-01-07", 2, 8);
INSERT INTO sales VALUES ("A", "2021-01-10", 3, 10);
INSERT INTO sales VALUES ("A", "2021-01-11", 3, 11);
INSERT INTO sales VALUES ("A", "2021-01-11", 3, 12);
INSERT INTO sales VALUES ("B", "2021-01-01", 2, 3);
INSERT INTO sales VALUES ("B", "2021-01-02", 2, 6);
INSERT INTO sales VALUES ("B", "2021-01-04", 1, 7);
INSERT INTO sales VALUES ("B", "2021-01-11", 1, 13);
INSERT INTO sales VALUES ("B", "2021-01-16", 3, 14);
INSERT INTO sales VALUES ("B", "2021-02-01", 3, 15);
INSERT INTO sales VALUES ("C", "2021-01-01", 3, 4);
INSERT INTO sales VALUES ("C", "2021-01-01", 3, 5);
INSERT INTO sales VALUES ("C", "2021-01-07", 3, 9);

-- 1. Total amount each customer spent
SELECT sales.customer_id, SUM(menu.price) as amount_per_customer
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id;

-- 2. How many days has each customer visited
SELECT customer_id, COUNT(DISTINCT(order_date)) as days_visited
FROM sales
GROUP BY customer_id;

-- 3. First item purchased per customer
SELECT sales.customer_id, menu.product_name
FROM sales 
JOIN menu ON sales.product_id = menu.product_id
WHERE order_date>= "2021-01-01"
GROUP BY sales.customer_id;

-- 4. Most purchased item
SELECT menu.product_name, COUNT(sales.product_id) as no_of_times_sold
FROM sales 
JOIN menu ON sales.product_id = menu.product_id
GROUP BY menu.product_id;  

-- 5. Item popular for each customer 
SELECT sales.customer_id, menu.product_name, COUNT(sales.product_id) as times_purchased
FROM sales
JOIN menu ON sales.product_id=menu.product_id
GROUP BY sales.product_id, sales.customer_id
ORDER BY times_purchased DESC, sales.customer_id DESC
LIMIT 5; 

-- 6. First purchase after becoming a member 
SELECT members.customer_id, menu.product_name
FROM members
JOIN sales ON members.customer_id=sales.customer_id
JOIN menu ON sales.product_id = menu.product_id
WHERE join_date IS NOT NULL AND order_date>join_date
GROUP BY customer_id;

-- 7. Last item before becoming a member
SELECT members.customer_id, menu.product_name, sales.order_date, 
RANK () OVER (PARTITION BY customer_id ORDER BY order_date) as rn
FROM members
JOIN sales ON members.customer_id=sales.customer_id
JOIN menu ON sales.product_id = menu.product_id
WHERE join_date IS NOT NULL AND order_date<join_date
ORDER BY customer_id, order_date desc
LIMIT 3;

-- 8. Total items and amount spent by each customer before becoming a memeber
SELECT sales.customer_id, SUM(menu.price) AS amount_spent_by_nonmember, COUNT(menu.product_id) AS items_bought_by_nonmember
FROM sales 
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE members.customer_id IS NOT NULL AND order_date<join_date 
GROUP BY customer_id;

-- 9. Loyalty points per customer when sushi has 2x?
WITH cte AS (
	SELECT sales.customer_id,
    CASE 
        WHEN sales.product_id = 1 THEN (COUNT(sales.product_id)*20*menu.price)
        ELSE (COUNT(sales.product_id)*10*menu.price)
    END AS points
FROM sales 
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id,sales.product_id)
SELECT customer_id, SUM(points) as loyalty_points
FROM cte 
GROUP BY customer_id;

-- 10. How many points do members have?
WITH new_table as (	
		SELECT sales.customer_id,menu.price,sales.order_date,members.join_date, date_add(members.join_date, INTERVAL 6 DAY) AS one_week
				FROM sales
                JOIN menu ON sales.product_id=menu.product_id
                JOIN members ON sales.customer_id =members.customer_id),
cte as (
	SELECT customer_id, order_date, 
	CASE WHEN order_date BETWEEN join_date AND one_week THEN price*20
     ELSE price*10
	END AS points
	FROM new_table)
SELECT customer_id, SUM(points) as loyalty_points 
FROM cte
WHERE order_date <"2021-02-01"
GROUP BY customer_id;

-- BONUS QUESTIONS
-- 11. join tables
SELECT sales.customer_id, sales.order_date, menu.product_name, menu.price,
	CASE WHEN sales.order_date>= members.join_date THEN "Y"
    ELSE "N"
    END AS members
FROM sales 
JOIN members ON sales.customer_id=members.customer_id
JOIN menu ON sales.product_id=menu.product_id
ORDER BY customer_id,order_date; 

-- 12 Rank Tables
WITH cte AS (
	SELECT sales.customer_id, sales.order_date, menu.product_name, menu.price,
	CASE WHEN sales.order_date>= members.join_date THEN "Y"
    ELSE "N"
    END AS members
FROM sales 
JOIN members ON sales.customer_id=members.customer_id
JOIN menu ON sales.product_id=menu.product_id)
SELECT *, 
	CASE WHEN members="N" THEN "null"
    ELSE RANK () OVER (PARTITION BY customer_id,members ORDER BY order_date)
    END AS ranking
FROM cte
ORDER BY customer_id,order_date;