Super Twitty
============

1.  Individuals working on this project

	    *  Dan Moore (drmoore2)
	    *  Omer Cansizoglu (ocansiz)
	    *  Sathish John (sjohn)

2.      Which test framework (Test::Unit or RSpec) you are using

	    *  Test::Unit

3.      Starting URL for the application

	    *  http://super-twitty.herokuapp.com

4.      Command(s) to run to start the app

	    *  Launch the link (http://super-twitty.herokuapp.com) via any browser
	
5.      Information and credential needed for testing

	    *  Use admin:admin for administrator access  (please do not modify the admin credentials)
	    *  New regular users can be created via the application
	    *  Administrator can provide admin access to other users

6.      Other notes (extra-credit functionality implemented, limitations, etc.)

	    *  Capybara is used for integration testing across all features
        *  Good code coverage with functional tests
	    *  Fake objects and setup of sessions in tests for session check
	    *  Backend validation check for the ownership of the posts such as
	         if @post.user_id == session[:user_id]  or session[:user_admin] == true
	    *  User can edit their own post (title & description)
        *  The 'admin' user cannot be deleted or edited by other users with admin privilege

7. How to run the automated tests from console

        rake test:functionals       # Run the functional tests in test/functional directory
        rake test:integration       # Run the integration tests in test/integration directory
        rake test:units             # Run the unit tests in test/unit directory

        Please make sure to have Capybara gem installed on your local host before running integration tests

ECE517-Project1