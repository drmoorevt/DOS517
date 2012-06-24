Super Twitty
============

1.  Individuals working on this project (include both names and unity IDs).
    If you worked alone, just include your name and unity ID
	    *  Dan Moore (drmoore2)
	    *  Omer Cansizoglu (ocansiz)
	    *  Sathish John (sjohn)

2.      Which test framework (Test::Unit or RSpec) you are using
	    *  Test::Unit

3.      Starting URL for the application.  This should generally be http://127.0.0.1:3000 for execution on your own computer.
	    *  http://super-twitty.herokuapp.com

4.      Command(s) to run to start the app
	    *  Launch the link (http://super-twitty.herokuapp.com) via any browser
	
5.      Information and credential needed for testing
	    *  Use admin:admin for administrator access  (please do not modify the admin credentials)
	    *  New regular users can be created via the application
	    *  Administrator can provide admin access to other users

6.      Other notes (extra-credit functionality implemented, limitations, etc.)
	    *  Capybara was used for integration testing
	    *  Good code coverage with functinal tests
	    *  Fake objects and setup of sessions in tests for session check
	    *  Backend validation check for the ownership of the posts such as
	         if @post.user_id == session[:user_id]  or session[:user_admin] == true

ECE517-Project1