# MoneyCashBoard Budget Tracker

## Overview:

MoneyCashBoard is a web application made with Ruby and Sinatra. Following a Model View Controller design, and a RESTful route 
architecture for saving and accessing data on a PostgreSQL database, it allows the user to track spending by spending type
(called Tagtype in the application) and Merchant, i.e. the store where the item was purchased. It also allows the user to find
a breakdown of the total spending by Tagtype, as well as by month.

## Project Brief:

You want to start tracking your spending in an attempt to be more frugal with money. You have decided to make a budgeting app to help you see where all of your money is being spent.

You must be able to create new Transactions ( which should include a merchant name, e.g. Tesco, and a value ) which have an associated Tag (e.g. 'food', 'clothes'). Your app would then be able to track a total, and display this in a view.

## MVP:

* Create new transactions
* Display a list of all transactions
* Display total amount spent
* Display total amount spent by tag

## Possible Extensions:

* CRUD actions (Create, Read, Update, Delete) for the transactions
* Show a warning when the total expenditure is over budget (set a hard coded budget first)
* Add a date to the transactions and view total spending by month
* Any other ideas you might come up with

## To Run the Application:

* The easiest and most convenient way to run this application is to type the link to the Heroku app into your browser:
* 'http://moneycashboard-version2.herokuapp.com/'. This takes the user directly to the app's home page, which contains
* instructions on how to use the application. This is the recommended way to access the application.

* Alternatively, a user may clone the repository to a local network folder using the 'git clone' command: 
* git clone git@github.com:Alexhub88/cc_wk5_project_moneycashboard_v2.git
* Enter the folder 
* Enter: 'ruby app.rb' and press enter
* Open Google Chrome and go to `http://localhost:4567/`, then press enter
* This will take the user to the Home page of the website, which then shows the user the options for finding the total 
* spending, and the breakdowns by Tagtype and Merchant.
