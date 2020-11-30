WorkoutBuddies - README
===

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
WorkoutBuddies is a workout app that pairs similar-leveled users and creates a workout agenda in which they can add or delete exercises. WorkoutBuddies also matches users for physical-related activities such as skateboarding, hiking, etc. Lastly, WorkoutBuddies also features user-messaging to assist users in the scheduling of workout sessions.

### App Evaluation
- **Category:** Fitness + Social Networking
- **Mobile:** The real-time availability of mobile is essential for this. This allows users from anywhere to connect with another likeminded user through a partnered workout session. The camera, audio sensors, and location will be used for this app.
- **Story:** Facilitates the building of meaningful connections between people by the means of an online, partnered workout session.
- **Market:** Any person seeking to build connections with others through an online workout session. Any person that find themselves lacking motivation to get in shape. //TODO Monetization
- **Habit:** Users are using it every other day or weekly to schedule a workout session with another person.
- **Scope:** V1 - Users can schedule a simple workout session with another user by Zoom. Users can also private message each other. V2 - Users can now choose different categories for their workouts (ie. skateboarding, hiking, etc) V3 - The integration of Google Meetings, Google Calendar, and Facetime 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [ ] User can create an account, login and out
* [x] User can select their level of expertise
 <img src="http://g.recordit.co/arb2uieWPk.gif" width=''>
* [x] User can create their own workouts
  <img src="http://g.recordit.co/WUoUlhOwlv.gif" width=''>
* [ ] User matches with another user with same the level of expertise
* [ ] User can meet others through Zoom
* [ ] User can search for other users

**Optional Nice-to-have Stories**

* Integration of Google Meetings, Google Calendar, and Facetime
* Allow the schedule of different categories of physical fitness
* Users can login through their Google Accounts/ Facebook Accounts

### 2. Screen Archetypes

* Login and Registration Screen   
    * User can log in  
    * User can create their accounts
* Home Screen 
    * User can view the people they can schedule a workout session with
    * User can view possible workout buddies
    * User can schedule workout plan
* Create Plan Screen
    * User can create a workout place 
* Workout Plan Screen
    * System generates a plan which the user can edit
* Suggestions Screen
    * User can view a full list of suggested workout buddies  
* Buddy Detail Screen
    * Displays the profile of another user
* New Event Screen
    * User can schedule a workout with another user
* User Profile Screen 
    * User can view user-related information
    * User can view upcoming, scheduled workouts
* Search Screen
    * Users can search for other pairs if current pairs aren't satisfactory
    * Search by workout expertise, category, and/or name
* View Chats Screen
    * User can view all chats
* Chat Screen
    * User can see the chat with another user
* FaceTime Screen
    * User can facetime another user and view the workout plan at the same time

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed
* Profile
* Search
* Chat

**Flow Navigation** (Screen to Screen)
* Login and Registration Screen
    * => Home Screen
* Home Screen
   * => Search Screen
   * => View Chats Screen
   * => Profile Screen
   * => Create Plan Screen
   * => Suggestions Screen
* Search Screen
    * => Buddy Detail Screen
* View Chats Screen
    * => Chats Screen
        * => FaceTime Screen
* User Profile Screen
* Create Plan Screen 
    * => Workout Plan Screen
* Suggestions Screen
    * => Buddy Details Screen
        * => New Event Screen

## Wireframes
<img src="https://raw.githubusercontent.com/lmxtiger/Codepath-APP-2020-Fall/main/Image%20from%20iOS.jpg" width=800>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
Workout Plan Schema
| Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the workout(default field) |
   | author        | Pointer to User| creator of the workout |
   | createdAt     | DateTime |date when routine is created (default field)|
   | updatedAt     | DateTime  | date when routine is last updated (default field) |
   | exercises     | Array of Integers |Exercises in each workout |
   | workoutLevel  | Int | Level of difficulty|

Exercise Schema
| Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId | Int | Unique id for the exercise |
   | name     | String |Name of exercise |
  
Full Exercise Schema
| Property      | Type     | Description |
   | ------------- | -------- | ------------|
   |exercise |Pointer to exercise | exercise |
   |sets     |Int | Amount of sets |
   |reps |Int |Amount of reps|
   |workoutPlan | Pointer to workoutPlan |the corresponding workout plan|

Additional User Information Schema
| Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | workoutLevel | Int |User’s level of expertise |
   | buddies | Array of Users | User’s Buddies |
   | upcomingRoutines | Array of Workouts | Upcoming workouts |
   | createdRoutines | Array of Workouts | created workout routines|
   | name | String| name of user|
   | connected | Boolean | connected with user|

Chat Message Schema
| Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | author | Pointer to User | person who posted|
   | recipient | Pointer to another user | the recipient of the post|
   | Post | String | the posted chat message|

### Models
(All code snipets of parse requests are on the DbViewController.swift file)
* Home Screen
    * (Read/Get) Query potential buddies of user
    * (Create/Post) New Workout Plan
* Suggestions Screen
    * (Read/Get) Query potential buddies of user
* Buddy's Details Screen
    * (Read/Get) Query buddy's details
* Create Plan Screen
    * (Create/Post) New Workout Plan
* Workout Plan Screen
    * (Read/Get) Query workout plan details
* Search Screen
    * (Read/Get) Query potential buddies of user
* Chat View Screen
    * (Read/Get) Query connected buddies
* Chat Screen
    * (Read/Get) Query messaged buddy
    * (Create/Post) New private message
    * (Delete) Posted Message
* User Profile Screen
    * (Read/Get) User details
    * (Create/Post) New Workout
    * (Update) Connected buddies
    * (Update) User Details
    * (Update) Workout Plans
    
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
