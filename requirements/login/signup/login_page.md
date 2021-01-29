## SignUp/Login 

### Requirements

1. ✅ Telephone field should initialize with no error message
2. ✅ Proceed button should initialize disabled
3. ✅ Mobile phone field should have a format mask of (##) ##### ####
4. ✅ Mobile phone field should check for a full length number
5. ✅ Mobile phone field cannot accept blank
6. ✅ Proceed button should turn into Enabled when all fields are completed

## Otp Verification 

### Requirements

7. If mobile number is invalid and therefore unable to send sms, throw an error message;
8. If firebase is unable to send sms due limitation, throw an error message;
9. SMS should show up in a dialog pop up, so user can see it while typing it
10. If user does not receive SMS, there must be an option to resend it.
11. If sms does not match, throw an error.
12. ✅ If sms match, then authenticate and login
13. If login is not successful, throw an error
14. ✅ If login is successful, land in home page
15. After user types sms code and click proceed, show a loading indicator.
16. Errors should show up in snack bar.
