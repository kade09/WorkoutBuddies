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

* User can create an account, login and out
* User can select their level of expertise
* User can edit a system generated agenda
* User matches with another user with same the level of expertise
* User can meet others through Zoom
* User can search for other users/

**Optional Nice-to-have Stories**

* Integration of Google Meetings, Google Calendar, and Facetime
* Allow the schedule of different categories of physical fitness
* Users can login through their Google Accounts/ Facebook Accounts

### 2. Screen Archetypes

* Login Screen
   * User can login
* Registration Screen
   * User can create their accounts
* Home Feed Screen
    * User can view the people they can schedule a workout session with
    * User can schedule workout
* Creation Screen
    * User can post a new workout if none of the workouts posted satisfies them
* Detail Screen
    * Displaying the details of the workouts
    * User can schedule workout
* Profile Screen
    * User can view user-related information
    * User can view upcoming, scheduled workouts
* Search Screen
    * Users can search for other pairs if current pairs aren't satisfactory
    * Search by workout expertise, category, and/or name

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed
* Profile
* Search

**Flow Navigation** (Screen to Screen)
* Login Screen
    * => Home Screen
* Registration Screen
    * => Home Screen
* Home Screen
   * => Detail Screen
   * => Creation Screen
* Search Screen
    * => Detail Screen
    * => Creation Screen
* Profile
    * => Detail Screen
    * => Creation Screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://imgur.com/jdwlKNE" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
