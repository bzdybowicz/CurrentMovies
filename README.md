# CurrentMovies
Currently played movies


General description:

1. Used architecture - MVVM + coordinators. Well known pattern, specific implementation is my own concept. (likely similar to others, but not copied whatsoever)
2. I did write Unit tests, but I did not bother to fully cover business logic in these as I believe it would not add more value to the task, given its purpose.
3. Views could be easily tested using snapshots
4. I just hard coded "en-Us", so dynamic language are not supported. This could be easily improved, but was not requires so YAGNI.
5. Swiftgen was used to generate string variables.
6. UI written in code only.
7. Developed with Xcode 14.3.1 with "Complete" set on "Strict Conccurency Checking". Deployment target 13.0 as per requirements. Tested on simulators and iPhone 14 Pro, iOS 16.6.1. Dark/light modes supported.


Comments to requirements.
1. "Wykorzystaj API..." - it was used. For security reasons you need to enter API key manually. They claim to have limit of 50 request per second and then you may get error 429 when too many requests are sent. I did experience timeouts instead.
2. "Wyświetl..." - done.
3. "Paginacja..." - done, nothing fancy, but it works (if error occurs then it stops working further, at some point you need to stop).
4. "Stwórz ekran..." - done, data passed in item. Favourite state maintained through user defaults storage.
5. "Wyszukiwanie..." - done.
6. "Powinniśmy mieć..." - done. Serduszko zamiast gwiazdki.

Git repository - done, swift - of course, iOS 13 deployment target, UI - nothing fancy, but clean, writte in UIKit fully programmatically. Time invested 1.5 business day (life went on, but commits pretty much match it).