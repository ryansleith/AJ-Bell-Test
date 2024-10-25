# Tasks

1. Refactor `MarketsTableViewController` from MVC into MVVM architecture. Any business logic in the View Model should be unit tested.

2. After completing the first task, what would you choose to do next? In this task we would like to see which would be your next priority and why.

Next Priority:
I’ve been deeply involved in front-end development, and my primary focus would be on creating a flexible UI. This would allow users to reorder, remove, and favorite their stock choices, ensuring that the interface remains user-centric and customizable. I would also prioritize keeping stock prices up-to-date, integrating a live market API. This could be achieved through WebSocket connections for real-time updates or intermittent API calls, depending on the tech stack available. Additionally, I would aim to minimize unnecessary UI updates by optimizing the CollectionView to refresh only the necessary indices, which would improve performance and user experience.

3. If you had more time what would you improve?

Further Improvements:
Given more time, I would focus on improving error handling and resilience, especially in cases of network failures or unexpected API issues. Additionally, I would refine the UI’s responsiveness to handle different devices and orientations more effectively. Another area of improvement would be optimising performance, particularly in how the app handles large datasets and ensuring smooth scrolling and fast data fetching. Lastly, I would implement more robust unit and UI tests to ensure the app’s stability across various scenarios.
