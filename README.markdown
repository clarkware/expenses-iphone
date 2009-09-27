Expenses
========

An example iPhone application that talks to a RESTful Rails application to:

* create an expense (name and amount) 
* read an expense
* update an expense
* delete an expense

That's it. It's your basic Rails scaffolding, iPhone style. 

The iPhone app is a *super* stripped down example of how to use
[ObjectiveResource](http://iphoneonrails.com/). The application focuses solely
on the basic CRUD operations. I deliberately left out any bells and whistles
so they don't get in the way of the fundamentals. Also, synchronous network
requests are used to keep the example dead simple. This is generally a bad
idea because synchronous network requests block the main UI thread, and people
don't like iPhone apps that appear to lock up. You should always use
asynchronous requests in your iPhone application.

For a more fleshed out example with asynchronous networking, authentication,
nested resources, and error handling, check out the [Budget
app](http://github.com/clarkware/budgets-iphone/).

Why?
----

This application is intended as a demonstration of how to use
[ObjectiveResource](http://iphoneonrails.com/) to manage a single resource
living in a Rails application. I first created this application as one of the
examples used in my [360|iDev talk](http://www.360idev.com) in October 2009.

Oh, and because programming is fun.  :-)

Quickstart
----------

1. Fire up the Rails application:

        $ cd server/expenses
        $ rake db:migrate
        $ ruby script/server
  
2. Point your trusty browser at the [running Rails app](http://localhost:3000/expenses) and create an example expense.

3. Open the iPhone project and run it!

        $ cd client/Expenses    
        $ open Expenses.xcodeproj

Screenshots
-----------

This app won't win any design awards, but that's not the point...

* [All Screens](http://github.com/clarkware/expenses-iphone/raw/master/screenshots/expenses.png)

Additional Resources
--------------------

Of course there are alternatives to ObjectiveResource, though they aren't designed specifically to work with Rails:

* [httpriot](http://github.com/caged/httpriot)
* [ASIHTTPRequest](http://allseeing-i.com/ASIHTTPRequest/)

Author
------

Mike Clark 
mike@clarkware.com
