## Running the Application

To run the application, use the following command in the terminal:
 python3 main.py
- To run into your system,change the password with your sql password in the main.py in the end.

## Importing the SQL Dumpfile

To import the SQL dumpfile, use the following command:

mysql -u your_username -p your_database_name < path/to/database_dump.sql
- Do take care that database should exist in your sql.If not first create the database using command - CREATE your_database_name;.


## Features

### Retrievals

#### Selection
1. **Select all menu items at a given price.**
2. **Select all the canteens which open before a particular time on a particular day of the week.**

#### Projection
1. **Return the names of all the menu items that have a price more than a specified amount.**
2. **Return the names of customers who are older than a specified age.**

#### Aggregate
1. **Find the minimum salary paid to the staff in a particular canteen.**
2. **Calculate the average cost of all menu items in a particular canteen.**

#### Searching
1. **Search for staff with names beginning with a particular prefix.**
2. **Search for menu items with names beginning with a particular prefix.**

### Analysis
1. **Find the top 5 selling items.**
2. **Get customer spending analysis (total spend).**
3. **Get the total revenue for each canteen.**

### Modifications

#### Insertion
1. **Insert a new customer.**
2. **Insert a new canteen.**

#### Deletion
1. **Delete a staff member.**
2. **Delete a customer.**

#### Update
1. **Update the price of a menu item.**
2. **Update the canteen for a staff member.**
