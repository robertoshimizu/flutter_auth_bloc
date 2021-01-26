Feature: Login
As a new and existing user
Need to provide a valid mobile number to enable the app to send a SMS
So I can enter the OTP code and signup safely

Scenario: Valid Data and Credentials
Given that the user provided valid mobile number
When the user sign up the app for the first time
Then the Auth Server will send a SMS to be entered by the user and validate it
Then the app will create a new and valid user, in this case it will 
And keep the user logged in

Scenario: Invalid Data
Given that the user provided invalid phone number
Then the Auth Server will throw an error message
Then the app should provided the error message
And prevent the user to sign up

Scenario: Invalid Credentials
Given that the user provided invalid OTP code (sms code verification)
Then the Auth Server will throw an error message
Then the app should provided the error message
And prevent the user to sign up