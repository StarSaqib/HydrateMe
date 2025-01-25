# HydrateMe
Project: Health Tracking targeting on hydration management.
App Name: Hydrate Me


This Readme File Contains:
1 - Setup instruction and how to run the application.
2 - Key decisions or assumptions made during development.
3 - Featured and Covered Points.





1 - Setup instructions and How to run application:


1) Xcode Setup:
Open the Mac App Store.
Search for Xcode.
Click Get or Install.
Wait for the download and installation to complete.
Launch Xcode and agree to the license terms.

2) Clone the Repository:
Open Terminal.
Run: 
cd <directort_where_you_want_to_clone>
git clone https://github.com/StarSaqib/HydrateMe.git
cd <project_directory>

3) Open the Project:
Double click the “Hydrate Me.xcodeproj” file in the project directory to open it in Xcode.

4) Run the Project:
Choose a simulator or connected device.
Click the Run button or press “Cmd + R”.

5) Build and Debug:
Ensure the build is successful and test the app on your preferred device.





2 - Key decisions or assumptions made during development:


1) Choice of Architecture: MVVM, MVC both. In beginning I have started on MVVM but I thought it will be more efficient when dealing with API so after few. I preferred MVC for basic and easy structure. Based on application I thought MVC architecture fits with the app’s requirements more Tham MVVM.

2) Core Data: Choosed Core Data for persistent storage for easier data management as per the requirements.

3) UI/UX Design Patterns: User UIKit for designing UI. For creating more engaging UI in very less time to provide more enhanced experience to the user.

4) Notifications: Provided reminder every hour for keep user hydrated and keep track of the progress.

5) Testing Strategy: unit testing is done for delivering product on time.

6) User Details: Added user details page for user name and age to enhance experience and give more accuracy to the user.

7) Added progress on Home: Added todays progress and hydration status with bar on home for user to track how much they have to drink to keep themselves hydrated.

8) UIColors: Colors are chosen by keeping Hydration Scale in mind by which UI color itself will show user hydration status. Table view cells and home view contains hydration scale colors according to hydration status.

9) info tab: Added info tab to understand hydration scale and how much to drink to keep ourselves hydrated.

10) Unit Options: Given user options to select unit like glass, bottle, large bottle etc as per there choice of hydration unit.





3 - Featured and Covered Points:


1) Water Intake Logging: Enabled easy recording of water consumption with option for different units.

2) Daily Tracking: Provided a comprehensive daily summary of hydration progress.

3) Add, Edit and Delete Logs: Allowed users to add, update, retrieve or delete entries for accuracy. (Covered CRUD functionalities for hydration logs)

4) Hydration Notification Reminder: Sent reminders every hour to encourage users to meet daily hydration goals.

5) UI/UX Excellence: Designed an intuitive and visually engaging and easy to use interface to enhance user interaction.

6) User Details: Allowed user to enter name and age for more better experience and accuracy with respect to age.

7) Provided info Charts: Allowed user to get information about hydration levels of scale.

8) Core Data: Used Core Data framework for storing data locally and more structured for health active logs.

9) Storyboard: Given best effort for providing best practices to deliver a seamless and visually appealing user experience to engage user.
