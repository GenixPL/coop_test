# coop_test

flutter ver: 3.16.0 (db7ef5bf9f59442b0e200a90587e8fa5e0c6336a) \
dart ver: 3.2.0 \
(in case some deps cause problems)

The app should work on macOS, iOS and Android, but I've built it mostly on macOS, so that's the most tested one.

<br>

I didn't pay much attention to UI, neither to:
- readability,
- separation
- performance (it can't be bad at this point)
- looks (I'm no designer `:(`)
- nor re-usability\
(all of this should be solved by a design system) 

Users cannot download the newsletters inside the app, idk if the returned data has changed (and the task hasn't), or something else (i often turn out to be blind), but it didn't seem worth to me to try scraping the websites and producing pdfs out of them.   

And I didn't want to put any keys into a public, + spend time on setuping them, so there is no navigation inside the app `:(` 


<br>

Separation into body and screen, when using instance providers, makes it less likely we will end up using wrong context. 
