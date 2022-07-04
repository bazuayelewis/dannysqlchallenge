# Week 1
First case study of the sqlchallenge (Danny's Resturant)
# Introduction
Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.

# Problem Statement
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

Danny has shared with you 3 key datasets for this case study:

* sales
* menu
* members

The dataset can be found [here](https://embed.db-fiddle.com/912b55b7-0c69-4f19-906f-aaef8ece6088#schema).

You can inspect the entity relationship diagram below.

# Entity Relationship Diagram
![Danny's Diner (1)](https://user-images.githubusercontent.com/107050974/173983740-bf95cd6c-89c4-49a2-b6ec-6f1584970918.png)

# Case Study Questions

1. What is the total amount each customer spent at the restaurant?

![1](https://user-images.githubusercontent.com/107050974/177212292-b5627bb4-04ae-4330-886a-a4309fc265da.png)

2. How many days has each customer visited the restaurant?

![2](https://user-images.githubusercontent.com/107050974/177212327-e6d85b49-46b5-4089-bda3-919cc0584802.png)

3. What was the first item from the menu purchased by each customer?

![3](https://user-images.githubusercontent.com/107050974/177212344-b7d3d1c0-2080-4e8c-bf89-20547053a218.png)

4. What is the most purchased item on the menu and how many times was it purchased by all customers?

![4](https://user-images.githubusercontent.com/107050974/177212369-fa1c8b49-bf1b-40e4-a06c-b13287a74385.png)

5. Which item was the most popular for each customer?

![5](https://user-images.githubusercontent.com/107050974/177212382-24297140-3034-4e34-9b5e-1ce906119e51.png)

6. Which item was purchased first by the customer after they became a member?

![6](https://user-images.githubusercontent.com/107050974/177212390-c1c84fc2-0974-41c7-9630-a915d044b035.png)

7. Which item was purchased just before the customer became a member?

![7](https://user-images.githubusercontent.com/107050974/177212406-673f3525-0be0-4c9b-82e2-2e0fbda4b226.png)

8. What is the total items and amount spent for each member before they became a member?

![8](https://user-images.githubusercontent.com/107050974/177212415-d59524ce-33ec-45f5-9c82-4e4d25f0bd46.png)

9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

![9](https://user-images.githubusercontent.com/107050974/177212428-1f81c00a-b50c-4a63-a430-4ec1c4d45ac0.png)

10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

![10](https://user-images.githubusercontent.com/107050974/177212451-2117f9e1-a6de-4ef2-aaf3-616cb21250a5.png)

BONUS QUESTION

11. JOIN ALL THINGS

![11](https://user-images.githubusercontent.com/107050974/177212641-7d254600-0b59-4238-8a07-793a34f18f0b.png)

12. RANK ALL THE THINGS

![12](https://user-images.githubusercontent.com/107050974/177212814-4341bdf0-6153-4410-9d3e-96b48e735b4c.png)
