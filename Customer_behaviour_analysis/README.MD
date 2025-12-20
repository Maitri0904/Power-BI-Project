<h1 align="center">🛒 Customer Shopping Behavior Analysis</h1>

<p align="center">
  <b>End-to-end data analysis project using Python, SQL, and Power BI</b>
</p>

<hr>

<h2>📌 Project Overview</h2>
<p>
This project analyzes customer shopping behavior for a retail company to understand
purchase patterns, customer segments, and factors influencing buying decisions.
The analysis covers demographics, product categories, discounts, subscriptions,
shipping preferences, and repeat purchases.
</p>

<p>
The goal is to generate actionable business insights that help improve
<strong>customer engagement</strong>, <strong>marketing strategies</strong>,
and <strong>long-term loyalty</strong>.
</p>

---

<h2>📂 Dataset Summary</h2>

<ul>
  <li><b>Total Rows:</b> 3,900</li>
  <li><b>Total Columns:</b> 18</li>
</ul>

<p><b>Key Data Includes:</b></p>
<ul>
  <li>Customer details: Age, Gender, Customer ID</li>
  <li>Product details: Item Purchased, Category, Size, Color, Season</li>
  <li>Transaction data: Purchase Amount, Location, Shipping Type, Payment Method</li>
  <li>Behavior data: Review Rating, Subscription Status, Discounts, Promo Codes</li>
  <li>Customer history: Previous Purchases</li>
</ul>

---

<h2>🧪 Exploratory Data Analysis (Python)</h2>

<h4>🔹 Data Loading</h4>

```python
import pandas as pd
df = pd.read_csv("customer_shopping_behavior.csv")
df.head()

<h4>🔹 Dataset Structure</h4>
df.shape
df.info()

<h4>🔹 Missing Values Check</h4>
df.isnull().sum()

<h4>🔹 Descriptive Statistics</h4>
df.describe()

<h4>🔹 Categorical Analysis</h4>
df['Category'].value_counts()
df['Season'].value_counts()

<h4>🔹 Duplicate Records</h4>
df.duplicated().sum()

<h2>🗄️ Business Analysis Using SQL</h2> <h4>1️⃣ Revenue by Gender</h4>
SELECT gender, SUM(purchase_amount) AS revenue
FROM customer
GROUP BY gender;

<h4>2️⃣ High-Spending Discount Users</h4>
SELECT customer_id, purchase_amount
FROM customer
WHERE discount_applied = 'Yes'
AND purchase_amount >= (
  SELECT AVG(purchase_amount) FROM customer
);

<h4>3️⃣ Top 5 Rated Products</h4>
SELECT TOP 5 item_purchased, AVG(review_rating) AS avg_rating
FROM customer
GROUP BY item_purchased
ORDER BY avg_rating DESC;

<h4>4️⃣ Shipping Type Spend Comparison</h4>
SELECT shipping_type, AVG(purchase_amount) AS avg_purchase
FROM customer
WHERE shipping_type IN ('Express', 'Standard')
GROUP BY shipping_type;

<h4>5️⃣ Subscription Impact on Spending</h4>
SELECT subscription_status,
COUNT(customer_id) AS total_customers,
ROUND(AVG(purchase_amount),2) AS avg_spend,
ROUND(SUM(purchase_amount),2) AS total_revenue
FROM customer
GROUP BY subscription_status;

<h4>6️⃣ Customer Segmentation</h4>
WITH customer_type AS (
  SELECT customer_id, previous_purchases,
  CASE
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
  END AS customer_segment
  FROM customer
)
SELECT customer_segment, COUNT(*) AS customer_count
FROM customer_type
GROUP BY customer_segment;

<h2>📊 Dashboard</h2> <p> An interactive dashboard was created using <b>Power BI</b> to visualize: </p> <ul> <li>Revenue trends</li> <li>Customer segments</li> <li>Category-wise performance</li> <li>Subscription and shipping behavior</li> </ul>
<h2>💡 Business Recommendations</h2> <ul> <li>Focus more on female customers by improving ads and product design</li> <li>Enhance subscription benefits to increase subscriber spending</li> <li>Convert loyal customers into subscribers using targeted offers</li> <li>Promote best-selling products by category</li> <li>Encourage express shipping for high-value orders</li> </ul>
<h2>🧠 Key Skills Demonstrated</h2> <ul> <li>Python (Pandas, EDA)</li> <li>SQL for business analysis</li> <li>Customer segmentation</li> <li>Dashboard creation (Power BI)</li> <li>Business insight generation</li> </ul>
<h2>✅ Conclusion</h2> <p> This project demonstrates an end-to-end data analysis workflow, from raw data to business recommendations. It reflects real-world analytical thinking and decision-making skills. </p> ```
