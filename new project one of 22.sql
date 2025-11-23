SELECT * 
FROM marketing_campaigns;


RENAME TABLE `customers. for new project` TO customers;

RENAME TABLE `employees.for new` TO employees;

SELECT *
FROM customer_data;

----cleaning first_name an& last_name 

SET SQL_SAFE_UPDATES = 0;



UPDATE customer_data

SET first_name = SUBSTRING_INDEX(first_name, ' ', 1)
WHERE first_name LIKE '% %';

UPDATE customer_data
SET first_name = CONCAT(
    UPPER(LEFT(first_name, 1)),
    LOWER(SUBSTRING(first_name, 2))
)
WHERE first_name IS NOT NULL;

 SELECT *
FROM customer_data;

 UPDATE customer_data
 SET last_name = CONCAT(
	UPPER(LEFT(last_name, 1)),
    LOWER(SUBSTRING(last_name, 2))
    )
    WHERE last_name IS NOT NULL;
 
--- cleaning the null_in email


UPDATE customer_data

SET email =  CASE 
   WHEN email IS NULL OR TRIM(email) = '' THEN 'NO DATA'
		 ELSE email
	END;
	
--- CLEANING THE null_IN CITY
UPDATE customer_data

SET city = CASE
	WHEN city IS NULL OR TRIM(city) = '' THEN 'NO DATA'
		ELSE city
	END;

 
 SELECT *
 FROM customer_data;
 
 --- CLEANING THE NULL_in PHONE,REGION ,SIGNUP_DATE, LOYALTY_SCORE____AND, PREFERRED_CHANNEL
 
 UPDATE customer_data
SET 
phone = CASE
	WHEN phone IS NULL OR TRIM(phone) = '' THEN 'NO DATA'
		ELSE phone
	END,
    
region = CASE
	WHEN region IS NULL OR TRIM(region) = '' THEN 'NO DATA'
		ELSE region
	END,
    
signup_date = CASE
	WHEN signup_date IS NULL THEN '2000-01-01'
		ELSE signup_date
	END,
    
loyalty_score = CASE
	WHEN loyalty_score IS NULL THEN 0
		ELSE loyalty_score
	END,
    
preferred_channel = CASE
	WHEN preferred_channel IS NULL OR TRIM(preferred_channel) = '' THEN 'NO DATA'
		ELSE preferred_channel
	END;  
        
 RENAME TABLE `employees.for new` TO employees;

 SELECT * 
 FROM employees;

ALTER TABLE employees
CHANGE role employee_role VARCHAR(50);



 ---- cleaning NAMES_section 
 
 
 UPDATE employees 
 SET first_name = CONCAT(
	UPPER(LEFT(first_name, 1)),
    LOWER(SUBSTRING(first_name, 2))
    )
 WHERE first_name IS NOT NULL;


UPDATE employees
SET last_name = CONCAT(
	UPPER(LEFT(last_name, 1)),
    LOWER(SUBSTRING(last_name, 2))
    )
WHERE last_name IS NOT NULL;

 SELECT * 
 FROM employees;

---cleaning hire_date

UPDATE employees
SET hire_date = CASE
  WHEN hire_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
       AND SUBSTRING_INDEX(hire_date, '/', 1) > 12
    THEN STR_TO_DATE(hire_date, '%d/%m/%Y')
  WHEN hire_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
       AND SUBSTRING_INDEX(hire_date, '/', 1) <= 12
    THEN STR_TO_DATE(hire_date, '%m/%d/%Y')
  WHEN hire_date REGEXP '^[0-9]{1,2}-[A-Za-z]{3}-[0-9]{2}$'
    THEN STR_TO_DATE(hire_date, '%d-%b-%y')
  ELSE hire_date
END
WHERE hire_date IS NOT NULL;


---- cleaning employee_role 

UPDATE employees
SET employee_role = CONCAT(
  UPPER(LEFT(SUBSTRING_INDEX(TRIM(employee_role), ' ', 1), 1)),
  LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(employee_role), ' ', 1), 2)),
  ' ',
  UPPER(LEFT(SUBSTRING_INDEX(TRIM(employee_role), ' ', -1), 1)),
  LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(employee_role), ' ', -1), 2))
)
WHERE employee_role LIKE '% %' AND employee_role NOT LIKE '% % %';

 
---- cleaning department 

UPDATE employees
SET department = CONCAT(
  UPPER(LEFT(TRIM(department), 1)),
  LOWER(SUBSTRING(TRIM(department), 2))
)
WHERE department NOT LIKE '% %';

---FILE_THRID

SET SQL_SAFE_UPDATES = 0;
SELECT * 
FROM marketing_campaigns;

UPDATE marketing_campaigns
  SET start_date = CASE
    WHEN start_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
      THEN STR_TO_DATE(start_date, '%Y-%m-%d')

    WHEN start_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
      THEN STR_TO_DATE(start_date, '%d-%m-%Y')

    WHEN start_date REGEXP '^[A-Za-z]+-[0-9]{1,2}-[0-9]{4}$'
      THEN STR_TO_DATE(start_date, '%M-%d-%Y')

    WHEN start_date REGEXP '^[A-Za-z]+,[0-9]{1,2},[0-9]{4}$'
      THEN STR_TO_DATE(start_date, '%M,%d,%Y')
     
     WHEN start_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
      THEN STR_TO_DATE(start_date, '%b %d, %Y') 

     WHEN start_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$' 
      THEN STR_TO_DATE(start_date, '%b %d, %Y')

	 WHEN start_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
	  THEN STR_TO_DATE(start_date, '%d/%m/%Y')
ELSE start_date
  END
  WHERE start_date IS NOT NULL;
  
  ----CLEANING_END_DATE
  
  UPDATE marketing_campaigns
  SET end_date = CASE
  WHEN end_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
  THEN STR_TO_DATE(end_date,  '%Y-%m-%d')
  
WHEN end_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
      THEN STR_TO_DATE(end_date, '%d-%m-%Y')
  
  WHEN end_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
      THEN STR_TO_DATE(end_date, '%b %d, %Y')

  WHEN end_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
     THEN STR_TO_DATE(end_date, '%d/%m/%Y')

 ELSE end_date
  END
WHERE end_date IS NOT NULL;


SELECT * 
FROM marketing_campaigns;

---CLEANING_CHANNEL

UPDATE marketing_campaigns
SET channel = CONCAT(
  UPPER(LEFT(SUBSTRING_INDEX(TRIM(channel), ' ', 1), 1)),
  LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(channel), ' ', 1), 2)),
  ' ',
  UPPER(LEFT(SUBSTRING_INDEX(TRIM(channel), ' ', -1), 1)),
  LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(channel), ' ', -1), 2))
)
WHERE channel LIKE '% %' AND channel NOT LIKE '% % %';



----- CLEANING_target_audience

UPDATE marketing_campaigns
SET target_audience = CASE
         WHEN REPLACE(LOWER(target_audience), ' ', '') LIKE '%18-25urbancustomers%' THEN '18-25 Urban Customers'
         WHEN REPLACE(LOWER(target_audience), ' ', '') LIKE '%30-45suburbanparents%' THEN '30-45 Suburban Parents'
         WHEN REPLACE(LOWER(target_audience), ' ', '') LIKE '%collegestudents%' THEN 'College Students'
         WHEN REPLACE(LOWER(target_audience), ' ', '') LIKE '%retiredprofessionals%' THEN 'Retired Professionals'
         ELSE target_audience
       END
  WHERE target_audience IS NOT NULL;

----cleaning_orders
SELECT *
FROM orders;


----CLEANING_ORDER_STATUS
SET SQL_SAFE_UPDATES = 0;

UPDATE orders
SET order_status = CONCAT(
UPPER(LEFT(TRIM(order_status), 1)),
LOWER(SUBSTRING(TRIM(order_status), 2))
)
WHERE order_status LIKE '%';



SELECT *
FROM orders;
----CLEANING_PAYMENT_METHOD

UPDATE orders
SET payment_method = 'CREDIT CARD'
WHERE REPLACE(LOWER(payment_method), ' ', '') LIKE '%cr%ditcard%';

----CLEANING_PAYMENT_METHOD

UPDATE ORDERS
SET payment_method = CASE
WHEN payment_method NOT LIKE '% %'
THEN CONCAT(
UPPER(LEFT(TRIM(payment_method), 1)),
UPPER(SUBSTRING(TRIM(payment_method), 2))
)
 WHEN payment_method LIKE '% %' AND payment_method NOT LIKE '% % %'
      THEN CONCAT(
UPPER(LEFT(SUBSTRING_INDEX(TRIM(payment_method), ' ', 1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(payment_method), ' ', 1), 2)),
' ',
UPPER(LEFT(SUBSTRING_INDEX(TRIM(payment_method), ' ', -1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(payment_method), ' ', -1), 2))
)
ELSE payment_method
END;


----CLEANING ORDER_date, SHIP_date, DELIVERY_date

UPDATE orders
  SET ship_date = CASE
  WHEN ship_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
  THEN STR_TO_DATE(ship_date,  '%Y-%m-%d')
  
WHEN ship_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
      THEN STR_TO_DATE(ship_date, '%d-%m-%Y')
  
  WHEN ship_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
      THEN STR_TO_DATE(ship_date, '%b %d, %Y')

  WHEN ship_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
     THEN STR_TO_DATE(ship_date, '%d/%m/%Y')

 ELSE ship_date
  END
WHERE ship_date IS NOT NULL;



SELECT ship_date
FROM orders;

----CLEANING order_date

UPDATE orders
  SET order_date = CASE
  WHEN order_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
  THEN STR_TO_DATE(order_date,  '%Y-%m-%d')
  
WHEN order_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
      THEN STR_TO_DATE(order_date, '%d-%m-%Y')
  
  WHEN order_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
      THEN STR_TO_DATE(order_date, '%b %d, %Y')

 WHEN order_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
     THEN STR_TO_DATE(order_date, '%d/%m/%Y')
     
WHEN order_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
   THEN STR_TO_DATE(order_date, '%d/%m/%Y')
   
 ELSE order_date
  END
WHERE order_date IS NOT NULL;


-----CLEANING_delivery_date

UPDATE orders
  SET delivery_date = CASE
  WHEN delivery_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
  THEN STR_TO_DATE(delivery_date,  '%Y-%m-%d')
  
WHEN delivery_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
      THEN STR_TO_DATE(delivery_date, '%d-%m-%Y')
  
  WHEN delivery_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
      THEN STR_TO_DATE(delivery_date, '%b %d, %Y')

 WHEN delivery_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
     THEN STR_TO_DATE(delivery_date, '%d/%m/%Y')

 WHEN delivery_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
   THEN STR_TO_DATE(delivery_date, '%d/%m/%Y')


 ELSE delivery_date
  END
WHERE delivery_date IS NOT NULL;


SELECT *
FROM products;


-----cleaning_launch_date
SET SQL_SAFE_UPDATES = 0;

UPDATE products
  SET launch_date = CASE
  WHEN launch_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
  THEN STR_TO_DATE(launch_date,  '%Y-%m-%d')
  
WHEN launch_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
      THEN STR_TO_DATE(launch_date, '%d-%m-%Y')
  
  WHEN launch_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
      THEN STR_TO_DATE(launch_date, '%b %d, %Y')

 WHEN launch_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
     THEN STR_TO_DATE(launch_date, '%d/%m/%Y')

 WHEN launch_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
   THEN STR_TO_DATE(launch_date, '%d/%m/%Y')


 ELSE launch_date
  END
WHERE launch_date IS NOT NULL;

SELECT product_name
FROM products;


----CLEANING_PRODUCT_NAME


UPDATE products
SET product_name = CASE
WHEN product_name NOT LIKE '% %'
THEN CONCAT(
UPPER(LEFT(TRIM(product_name), 1)),
UPPER(SUBSTRING(TRIM(product_name), 2))
)
 WHEN product_name LIKE '% %' AND product_name NOT LIKE '% % %'
      THEN CONCAT(
UPPER(LEFT(SUBSTRING_INDEX(TRIM(product_name), ' ', 1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(product_name), ' ', 1), 2)),
' ',
UPPER(LEFT(SUBSTRING_INDEX(TRIM(product_name), ' ', -1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(product_name), ' ', -1), 2))
)
ELSE product_name
END;



SELECT *
FROM returns;


-----CLEANING_RETURN_REASON


UPDATE returns
SET return_reason = CASE
WHEN return_reason NOT LIKE '% %'
THEN CONCAT(
UPPER(LEFT(TRIM(return_reason), 1)),
UPPER(SUBSTRING(TRIM(return_reason), 2))
)
 WHEN return_reason LIKE '% %' AND return_reason NOT LIKE '% % %'
      THEN CONCAT(
UPPER(LEFT(SUBSTRING_INDEX(TRIM(return_reason), ' ', 1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(return_reason), ' ', 1), 2)),
' ',
UPPER(LEFT(SUBSTRING_INDEX(TRIM(return_reason), ' ', -1), 1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(return_reason), ' ', -1), 2))
)
ELSE return_reason
END; 


-----CLEANING_RETURN_DATE



UPDATE returns
  SET return_date = CASE
  WHEN return_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
  THEN STR_TO_DATE(return_date,  '%Y-%m-%d')
  
WHEN return_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
      THEN STR_TO_DATE(return_date, '%d-%m-%Y')
  
  WHEN return_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
      THEN STR_TO_DATE(return_date, '%b %d, %Y')

 WHEN return_date REGEXP '^[A-Za-z]{3} [0-9]{1,2}, [0-9]{4}$'
     THEN STR_TO_DATE(return_date, '%d/%m/%Y')

 WHEN return_date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
   THEN STR_TO_DATE(return_date, '%d/%m/%Y')


 ELSE return_date
  END
WHERE return_date IS NOT NULL;




SELECT *
FROM warehouses;

-----CLEANING REGION 

UPDATE warehouses
SET region = CONCAT(
    UPPER(LEFT(TRIM(region), 1)),
    LOWER(SUBSTRING(TRIM(region), 2))
)
WHERE region NOT LIKE '% %';

----CLEANING_REGION_NAME 

UPDATE warehouses
SET region = CASE
         WHEN REPLACE(LOWER(region), ' ', '') = 'MINN3SOTA' THEN 'Minnesota'
         WHEN REPLACE(LOWER(region), ' ', '') = 'V3RMONT' THEN 'Vermont'
	
  ELSE region 
  END 
  WHERE region IS NOT NULL;
    
  SELECT *
  FROM warehouses;
  
  -----cleaning_managers 
  
  
  UPDATE warehouses
SET manager = CONCAT(
   UPPER(LEFT(SUBSTRING_INDEX(TRIM(manager), ' ', 1), 1)),
   LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(manager), ' ', 1), 2)),
   ' ',
   UPPER(LEFT(SUBSTRING_INDEX(TRIM(manager), ' ', -1), 1)),
   LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(manager), ' ', -1), 2))
)
WHERE manager LIKE '% %' AND manager NOT LIKE '% % %';
  
  ----cleaning opened_date
  
UPDATE warehouses
SET opened_date = CASE

    WHEN opened_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
	THEN STR_TO_DATE(opened_date, '%m/%d/%Y')

    WHEN opened_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
	THEN STR_TO_DATE(opened_date, '%Y-%m-%d')

ELSE NULL
END
WHERE TRIM(opened_date) <> '';

SELECT DATE_FORMAT(opened_date, '%d/%m/%Y') AS formatted_opened_date
FROM warehouses;



select opened_date
from warehouses;








