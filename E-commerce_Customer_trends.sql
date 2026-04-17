#DATA CLEANING
UPDATE e_commerce.customer_trends
SET 
	`Total Purchases` = REPLACE(`Total Purchases`, '$', ""), 
	`Purchase Amount (USD)` = REPLACE(`Purchase Amount (USD)`, '$', ""),
	 `Total Purchases` = REPLACE(`Total Purchases`, ',', ""),
	 `Purchase Amount (USD)` = REPLACE(`Purchase Amount (USD)`, ',', "")
     ;

ALTER TABLE e_commerce.customer_trends
MODIFY `Total Purchases` INT (200);

ALTER TABLE e_commerce.customer_trends
MODIFY `Purchase Amount (USD)` INT (200);

#GENERAL QUERY
SELECT * FROM e_commerce.customer_trends;


#OUR MOST VALUABLE CUSTOMERS (AGE DISTRIBUTION)
SELECT  `Age Range` AS Age_Range,
COUNT(`Customer ID`) AS No_of_Customers,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases,
ROUND(
AVG(`Total Purchases`) ,1)
AS Average_of_Total_Purchases,
ROUND
		(COUNT(`Customer ID`) * 100/SUM(COUNT(`Customer ID`)) OVER(),1) 
		AS Percentage
FROM e_commerce.customer_trends
GROUP BY Age_Range
ORDER BY Percentage DESC;


#OUR MOST VALUABLE CUSTOMERS (GENDER DISTRIBUTION)
SELECT Gender,
COUNT(`Customer ID`) AS No_of_Customers,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases,
ROUND(
			AVG(`Total Purchases`),1)
	AS Average_of_Total_Purchases,
ROUND(
			COUNT(`Customer ID`) * 100.0 / SUM(COUNT(`Customer ID`)) OVER (),1)
            AS Percentage
FROM e_commerce.customer_trends
GROUP BY Gender
ORDER BY Sum_of_Total_Purchases DESC;


#HIGH-FREQUENCY BUYERS
SELECT *
FROM e_commerce.customer_trends
ORDER BY `Previous Purchases` DESC;

#HIGH-FREQUENCY BUYERS WITH 50 OR MORE PREVIOUS PURCHASES
SELECT Gender,
COUNT(`Customer ID`) No_of_Customers,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases,
ROUND(
			AVG(`Total Purchases`),1)
		AS Average_of_Total_Purchases
FROM e_commerce.customer_trends
WHERE `Previous Purchases` >=50
GROUP BY Gender;

#COUNT OF CUSTOMERS WITH 50 OR MORE PREVIOUS PURCHASES
SELECT COUNT(`Customer ID`) No_of_Customers_with_more_than_50_purchases
FROM e_commerce.customer_trends
WHERE `Previous Purchases` >=50;

#BEST PRODUCTS DRIVING REVENUE (CATEGORY) FOR HIGH FREQUENCY BUYERS
SELECT Category,
COUNT(`Customer ID`) AS No_of_Customers,
SUM(`Total Purchases`) AS Amount_Purchased,
ROUND(
			COUNT(`Customer ID`) * 100.0 / SUM(COUNT(`Customer ID`)) OVER (),1)
            AS Percentage
FROM e_commerce.customer_trends
WHERE `Previous Purchases`>=50
GROUP BY Category
ORDER BY Amount_Purchased DESC;

#BEST PRODUCTS DRIVING REVENUE (CATEGORY)
SELECT Category,
COUNT(`Item Purchased`) AS No_of_Times_Purchased,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases,
ROUND(
			COUNT(`Item Purchased`) * 100.0 / SUM(COUNT(`Item Purchased`)) OVER (),1)
            AS Percentage
FROM e_commerce.customer_trends
GROUP BY Category
ORDER BY Sum_of_Total_Purchases DESC;

#BEST PRODUCTS DRIVING REVENUE (ITEMS)
SELECT `Item Purchased` AS Items,
COUNT(`Item Purchased`) AS No_of_Times_Purchased,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases,
ROUND(
			AVG(`Total Purchases`),1) 
		AS Average_of_Total_Purchases
FROM e_commerce.customer_trends
GROUP BY Items
ORDER BY No_of_Times_Purchased DESC;

#BEST PRODUCTS DRIVING REVENUE (SIZE)
SELECT Size, 
COUNT(`Previous Purchases`) AS No_of_Times_Purchased,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases
FROM e_commerce.customer_trends
GROUP BY Size
ORDER BY No_of_Times_Purchased DESC;

#SEASONAL TRENDS
SELECT Season, 
COUNT(`Item Purchased`) AS No_of_Times_Purchased,
SUM(`Purchase Amount (USD)`) AS Amount_Purchased
FROM e_commerce.customer_trends
GROUP BY Season
ORDER BY Amount_Purchased DESC;

#PURCHASE AMOUNT
SELECT SUM(`Total Purchases`) AS Total_Amount_Purchased_by_Customers,
ROUND(
			AVG(`Total Purchases`),1) AS Average_Amount
FROM e_commerce.customer_trends;

#HOW OFTEN DO CUSTOMERS BUY
SELECT `Frequency of Purchases` AS Frequency_of_Purchases,
COUNT(`Customer ID`) Customer_Count, 
ROUND(
				COUNT(`Customer ID`) *100/SUM(COUNT(`Customer ID`)) OVER(),1
                )
                AS Percentage
FROM e_commerce.customer_trends
GROUP BY Frequency_of_Purchases
ORDER BY Customer_Count  DESC;

#HOW OFTEN DO FEMALES BUY
SELECT `Frequency of Purchases` AS Frequency_of_Purchases,
COUNT(`Gender`) Customer_Count ,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases,
ROUND(
			AVG(`Total Purchases`),1
)
 AS Average_of_Total_Purchases
FROM e_commerce.customer_trends
WHERE Gender = 'Female'
GROUP BY Frequency_of_Purchases
ORDER BY Customer_Count  DESC;

#WHAT PAYMENT METHODS ARE MOST USED
SELECT `Preferred Payment Method` Payment_Method,
COUNT(`Customer ID`) No_of_Times_used,
SUM(`Total Purchases`) AS Total_Amount_Purchased
FROM e_commerce.customer_trends
GROUP BY Payment_Method
ORDER BY No_of_Times_used DESC;

#NO OF CUSTOMERS PER LOCATION
 SELECT DISTINCT Location, 
 COUNT(`Customer ID`) AS No_of_Customers,
 SUM(`Total Purchases`) AS Total_Amount_Purchased,
 ROUND(
  SUM(`Customer ID`) * 100.0 / SUM(SUM(`Customer ID`)) OVER(),1)
  AS Percentage
 FROM e_commerce.customer_trends
 GROUP BY Location
 ORDER BY No_of_Customers DESC;

#NO OF FEMALES WITH THE BEST PRODUCT PURCHASE
SELECT DISTINCT `Item Purchased`, 
COUNT(`Customer ID`) No_of_Customers,
SUM(`Total Purchases`) AS Sum_of_Total_Purchases,
AVG(`Total Purchases`) AS Average_of_Total_Purchases
FROM e_commerce.customer_trends
WHERE Gender = 'Female'
GROUP BY `Item Purchased`
ORDER BY No_of_Customers DESC;

#NO OF CUSTOMERS THAT USED DISCOUNT
SELECT `Discount Applied` Discount,
COUNT(`Customer ID`) Customer_Count ,
ROUND(
			COUNT(`Customer ID`) * 100.0 / SUM(COUNT(`Customer ID`)) OVER (),1)
            AS Percentage
FROM e_commerce.customer_trends
GROUP BY Discount;

#NO OF CUSTOMERS THAT USED PROMO
SELECT `Promo Code Used` Promo_Code,
COUNT(`Customer ID`) Customer_Count ,
ROUND(
			COUNT(`Customer ID`) * 100.0 / SUM(COUNT(`Customer ID`)) OVER (),1)
            AS Percentage
FROM e_commerce.customer_trends
GROUP BY Promo_Code;

#SELECT ALL THE RECORDS IN THE TABLE
SELECT * 
FROM e_commerce.customer_trends;