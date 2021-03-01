## (Authentication + Login) Bloc

### Requirements

1. ✅ For first-time users, app should start with Splash page
2. ✅ Splash should drive user to signup/login
3. ✅ For loggedIn users, app should start already at home page
4. States:
   ✅ - Uninitialized
   ✅ - Unauthenticated -> Splash Page
   ✅ - LoginInitial -> PhoneLoginPage
   ✅ - PhoneVerified/OtpSentState -> Phone VerificationPage
   ✅ - OtpVerifiedState -> After confirming yield to Authenticated or Exception
   ✅ - Authenticated/LoginCompleteState -> HomePage
   ✅ - Loading
   ✅ - ExceptionState
5. Events:
   - AppStarted
   - 