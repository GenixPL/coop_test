# coop_test

flutter ver: 3.16.0 (db7ef5bf9f59442b0e200a90587e8fa5e0c6336a) \
dart ver: 3.2.0 \
(in case some dep cause problems)

The app should work on macOS, iOS and Android, but I've built it mostly on macOS, so that's the most tested one.

<br>

I didn't pay much attention to UI, neither to:
- readability,
- separation
- performance (it can't be bad at this point)
- looks (I'm no designer `:(`)
- nor re-usability

(all of this should be solved by a design system) 

<br>

Separation into body and screen, when using instance providers, makes it less likely we will end up using wrong context. 
