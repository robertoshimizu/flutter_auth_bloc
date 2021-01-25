Feature: Cadastro
As a new user
Need to provide personal data to enable the app to identify me
So I can re enter or keep logged in safely

Scenario: Valid Data
Given that the user provided valid data
When the user sign up the app for the first time
Then the app will create a new and valid user
And keep the user logged in

Scenario: Invalid Data
Given that the user provided invalid data
Then the app should provided and error message
And prevent the user to sign up