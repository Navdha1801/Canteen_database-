import subprocess as sp
import pymysql
import pymysql.cursors
from tabulate import tabulate


def TopItem():
    try:
        query = "SELECT Item_name, Quantity, CanteenID, SUM(Units_sold) AS TotalUnitsSold \
                    FROM MENU_ITEMS \
                    GROUP BY Item_name, Quantity, CanteenID \
                    ORDER BY TotalUnitsSold DESC LIMIT 5;"
        mycur.execute(query)
        output = mycur.fetchall()
        if mycur.rowcount != 0:
            print()
            print("Output: ")
            print(tabulate(output , headers = "keys" , tablefmt = "grid"))
        else:
            print()
            print("No rows selected!")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>>", e)

    return

def CustomerAnalyze():
    try:
        query = "SELECT c.CustomerID, c.Cname, SUM(o.TotalPrice) AS TotalSpent \
                    FROM CUSTOMER AS c \
                    LEFT JOIN ORDER_TABLE AS o \
                    ON c.CustomerID = o.CustomerID \
                    GROUP BY c.CustomerID, c.Cname \
                    ORDER BY TotalSpent DESC;"
        mycur.execute(query)
        output = mycur.fetchall()
        if mycur.rowcount != 0:
            print()
            print("Output: ")
            print(tabulate(output , headers = "keys" , tablefmt = "grid"))
        else:
            print()
            print("No rows selected!")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>>", e)

    return

def TotRevenue():
    try:
        query = "SELECT C.CanteenID, SUM(O.TotalPrice) AS TotalRevenue \
                    FROM CANTEEN C \
                    JOIN ORDER_TABLE O ON C.CanteenID = O.CanteenPlaced \
                    GROUP BY C.CanteenID;"
                    
        mycur.execute(query)
        output = mycur.fetchall()
        if mycur.rowcount != 0:
            print()
            print("Output: ")
            print(tabulate(output , headers = "keys" , tablefmt = "grid"))
        else:
            print()
            print("No rows selected!")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>>", e)

    return

def analysis():
    while 1:
        print()
        print("1. Find the 5 Top Selling Items!")
        print("2. Get a Customer Spending Analysis!")
        print("3. Get the Total Revenue for each Canteen!")

        option = int(input("Enter choice: "))

        if option == 1:
            TopItem()
        elif option == 2:
            CustomerAnalyze()
        elif option == 3:
            TotRevenue()
        else:
            print("Invalid Input")
        return
    
def DeleteStaff():
    try:
        print()
        staff_id = int(input("Enter the staffID: "))

        query = f"""
            DELETE STAFF, STAFF_DETAILS
            FROM STAFF
            LEFT JOIN STAFF_DETAILS ON STAFF.Aadhar = STAFF_DETAILS.Aadhar
            WHERE STAFF.StaffID = {staff_id};
        """


        mycur.execute(query)

        mycon.commit()
        print("Staff member and related details deleted successfully.")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print("Error:", e)

    return

def DeleteCustomer():
    try:
        print()
        
        
        customer_id = int(input("Enter the Customer ID: "))
        
        query = f"DELETE FROM CUSTOMER WHERE CustomerID = {customer_id};"

        mycur.execute(query)

        mycon.commit()
        print("Customer and related entries deleted successfully.")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>>", e)

    return

def delete():
        while 1:
            print()
            print("1. Delete a Staff Member")
            print("2. Delete a Customer")

            option = int(input("Enter choice: "))

            if option == 1:
                DeleteStaff()
            elif option == 2:
                DeleteCustomer()
            else:
                print("Invalid Input")
            return

def insert_customer():
    try:
        # Takes customer details as input
        row = {}
        print("Enter new customer's details: ")
        row["CustomerID"] = int(input("Customer ID: "))  # Include this line for CustomerID
        row["Cname"] = input("Customer Name: ")
        row["CDOB"] = input("Customer Date of Birth (YYYY-MM-DD): ")
        row["CustomerRole"] = input("Customer Role: ")

        query = "INSERT INTO CUSTOMER (CustomerID, Cname, CDOB, CustomerRole) VALUES (%s, %s, %s, %s)"
        values = (row["CustomerID"], row["Cname"], row["CDOB"], row["CustomerRole"])

        mycur.execute(query, values)
        mycon.commit()

        print("Inserted into CUSTOMER table")

    except Exception as e:
        mycon.rollback()
        print("Failed to insert into CUSTOMER table")
        print("Error:", e)

def insert_canteen():
    try:
        # Takes canteen details as input
        row = {}
        print("Enter new canteen's details: ")
        row["CanteenID"] = input("Canteen ID: ")
        row["Opening_Year"] = input("Opening Year (YYYY-MM-DD): ")
        row["Location"] = input("Location: ")

        query = "INSERT INTO CANTEEN (CanteenID, Opening_Year, Location) VALUES (%s, %s, %s)"
        values = (row["CanteenID"], row["Opening_Year"], row["Location"])

        mycur.execute(query, values)
        mycon.commit()

        print("Inserted into CANTEEN table")

    except Exception as e:
        mycon.rollback()
        print("Failed to insert into CANTEEN table")
        print("Error:", e)

def insert():
    # insert a mess committee member or new canteen
    print()
    print("1. Insert a new Customer: ")
    print("2. Insert a new Canteen: ")
    choice = int(input("Enter Choice: "))

    if choice == 1:
        insert_customer()
    elif choice==2:
        insert_canteen()
    else:   
        print()
        print("invalid input")
    return 0

def update_menu_item_price():
    try:
        item_name = input("Enter the item name to update: ")
        canteen_id = input("Enter the canteen ID: ")
        quantity = input("Enter the quantity: ")
        new_price = float(input("Enter the new price: "))

        query = "UPDATE MENU_ITEMS SET Price = %s WHERE Item_name = %s AND CanteenID = %s AND Quantity = %s"
        values = (new_price, item_name, canteen_id, quantity)

        mycur.execute(query, values)
        mycon.commit()

        print(f"Updated price for {item_name} in MENU_ITEMS table for Canteen {canteen_id} and Quantity {quantity}")

    except Exception as e:
        mycon.rollback()
        print("Failed to update MENU_ITEMS table")
        print("Error:", e)

def update_staff_can_id():
    try:
        staff_id = int(input("Enter the staff ID to update: "))
        new_can_id = input("Enter the new Canteen ID: ")

        query = "UPDATE STAFF SET CanID = %s WHERE StaffID = %s"
        values = (new_can_id, staff_id)

        mycur.execute(query, values)
        mycon.commit()

        print(f"Updated Canteen ID for staff with ID {staff_id} in STAFF table")

    except Exception as e:
        mycon.rollback()
        print("Failed to update STAFF table")
        print("Error:", e)

def update():
    while 1:
        # update the cost of beverages
        print()
        print("1. Update the price of a menu item: ")
        print("2. Update the CanteenID of a staff member: ")
        choice = int(input("Enter update choice: "))
        if choice == 1:
            update_menu_item_price()
        elif choice == 2:
            update_staff_can_id()
        else:
            print("Invalid input")
        return

def selection():
    while 1:
            try:
                print("1. Display all the menu items available at a particular price.")
                print("2. Display all the canteens that open before a certain time on a certain day")
                chSelect = int(input("Enter choice: "))

                if chSelect == 1:
                    price = float(input("Enter the price at which food items should be displayed: "))
                    query = "select Item_name as Item, Quantity, Price, Units_sold as 'Units Sold', CanteenID as Canteen from MENU_ITEMS where Price = {} and 1=1 ".format(price)

                elif chSelect == 2:
                    day = input("Enter the day: ")
                    day = day.capitalize()
                    day = day[:3]
                    time = input("Enter the time (HHMM): ")
                    query = f"""
                    SELECT CanteenID as Canteen, Opening_Year as 'Opening Year', Location, {day}
                    FROM CANTEEN
                    WHERE CAST({day} AS UNSIGNED) < {time}
                """
                    #time = input("Enter the time: ")
                    #query = "select CanteenID as Canteen, Opening_year as 'Opening Year', Location, {} from CANTEEN where '{}' < {}".format(day, day, time)
                    #query = f"SELECT CanteenID as Canteen, Opening_Year as 'Opening Year', Location, {day} FROM CANTEEN WHERE TIME({day}) < '{time}'"
                else:
                    print("Invalid Input!")
                    return
                mycur.execute(query)
                output = mycur.fetchall()

                if mycur.rowcount != 0:
                    print()
                    print("Output: ")
                    print(tabulate(output, headers="keys", tablefmt="psql"))
                else:
                    print()
                    print("No rows selected")
            except Exception as e:
                mycon.rollback()
                print("Failed to insert record into database")
                print(">>>>>>>>>>>>> ", e)

            return

def projection():
    while 1:
        try:
            print()
            print("1. Display the names of all the menu items that have a price more than Rs 'X'.")
            print("2. To display the names of the customers who are older than 'Y' years of age.")
            print()
            chProj = int(input("Enter choice: "))

            if chProj == 1:
                amount = int(input("Enter the amount: "))
                query = "select Item_name, Price as Item from MENU_ITEMS where Price > {} ".format(amount)

            elif chProj == 2:
                age = int(input("Enter the age: "))
                # use the DOB to calculate the age
                query = "select Cname as Name, TIMESTAMPDIFF(YEAR, CDOB, CURDATE()) as Age from CUSTOMER where TIMESTAMPDIFF(YEAR, CDOB, CURDATE()) > {}".format(age)
            
            else:
                print()
                print("Invalid Input!")
                return
            mycur.execute(query)
            output = mycur.fetchall()
            if mycur.rowcount != 0:
                print()
                print(tabulate(output , headers = "keys" , tablefmt = "psql"))
            else:
                print()
                print("No rows selected!")

        except Exception as e:
            mycon.rollback()
            print("Failed to insert record into database")
            print(">>>>>>>>>>>>> ", e)
        return

def MinSalary():
    """Gets the minimum salary of the staff working in a particular canteen."""
    try:
        canteen = input("Enter Canteen Name: ")
        query = "SELECT MIN(Salary) AS 'Minimum Salary' FROM STAFF where CanID = '%s';" %(canteen)
        mycur.execute(query)
        output = mycur.fetchall()
        if mycur.rowcount != 0:
            print()
            print("Output: ")
            print(tabulate(output , headers = "keys" , tablefmt = "psql"))
        else:
            print()
            print("No rows selected!")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>> ", e)

    return

def AvgCost():
    """Gets the average cost of an item in a particular canteen."""
    try:
        canteen = input("Enter Canteen Name: ")
        query = "SELECT AVG(Price) AS 'Average Cost' FROM MENU_ITEMS where CanteenID = '%s';" %(canteen)
        mycur.execute(query)
        output = mycur.fetchall()
        if mycur.rowcount != 0:
            print()
            print("Output: ")
            print(tabulate(output , headers = "keys" , tablefmt = "grid"))
        else:
            print()
            print("No rows selected!")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>> ", e)

    return

def aggregate():
    while 1:
        print("1. Display AVG cost of an item in a canteen.")
        print("2. Display MIN salary of the staff working in a canteen.")

        option = int(input("Enter choice: "))

        if option == 1:
            AvgCost()
        elif option == 2:
            MinSalary()
        else:
            print("Invalid Input")
        return

def SearchStaff():
    """Searches for staff with names beginning with a particular prefix"""
    try:
        prefix = input("Enter prefix: ")
        query = "SELECT Name FROM STAFF_DETAILS WHERE Name LIKE '{}%';".format(prefix)
        mycur.execute(query)
        output = mycur.fetchall()
        if mycur.rowcount != 0:
            print()
            print("Output: ")
            print(tabulate(output , headers = "keys" , tablefmt = "psql"))
        else:
            print()
            print("No rows selected!")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>>", e)

    return

def SearchItem():
    """Searches for Menu Items with names beginning with a particular prefix"""
    try:
        prefix = input("Enter prefix: ")
        query = "SELECT Item_name as Name FROM MENU_ITEMS WHERE Item_name LIKE '{}%';".format(prefix)
        mycur.execute(query)
        output = mycur.fetchall()
        if mycur.rowcount != 0:
            print()
            print("Output: ")
            print(tabulate(output , headers = "keys" , tablefmt = "psql"))
        else:
            print()
            print("No rows selected!")

    except Exception as e:
        mycon.rollback()
        print("Failed to execute")
        print(">>>>>>>>>>>>>", e)

    return

def search():
    while 1:
        print()
        print("1. Search for staff with names beginning with a particular prefix.")
        print("2. Search for Menu Items with names beginning with a particular prefix.")

        print()
        option = int(input("Enter choice: "))

        if option == 1:
            SearchStaff()
        elif option == 2:
            SearchItem()
        else:
            print("Invalid Input")
        return


def mapFuncCall(ch):
    """
    This function maps the choice entered by the user to the correct function.
    """
    if ch == 1:
        selection()
    elif ch == 2:
        projection()
    elif ch == 3:
        aggregate()
    elif ch == 4:
        search()
    elif ch == 5:
        insert()
    elif ch == 6:
        update()
    elif ch == 7:
        delete()
    elif ch == 8:
        analysis()



# Global
while 1:
    tmp = sp.call("clear", shell=True)

    username = input("Username: ")
    password = input("Password: ")

    try:
        mycon = pymysql.connect(
            host="localhost",
            port=3306,
            user="root",
            password="Nav@1801",
            db="Canteen_Database",
            cursorclass=pymysql.cursors.DictCursor,
        )

        tmp = sp.call("clear", shell=True)

        if mycon.open:
            print("Connected to database!")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE >")

        mycur = mycon.cursor()

        while 1:
            tmp = sp.call("clear", shell=True)

            # Note: PLS CHANGE THE MENU (I AM JUST GIVING THE BASIC FORMAL OPTIONS FOR NOW)
            print()
            print("1. Press 1 for SELECTION")
            print("2. Press 2 for PROJECTION")
            print("3. Press 3 for AGGREGATE")
            print("4. Press 4 for SEARCH")
            print("5. Press 5 for INSERT")
            print("6. Press 6 for UPDATE")
            print("7. Press 7 for DELETE")
            print("8. Press 8 for ANALYSIS")
            print("9. Logout")
            print()
            ch = int(input("Enter choice: "))
            tmp = sp.call("clear", shell=True)
            if ch == 9:
                exit()
            else:
                mapFuncCall(ch)
                tmp = input("Enter any key to CONTINUE > ")

    except Exception as e:
        tmp = sp.call("clear", shell=True)
        print(e)
        print(
            "Connection Refused: Either username or password is incorrect or user doesn't have access to database"
        )
        tmp = input("Enter any key to CONTINUE > ")