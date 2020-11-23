import Parse
    

let currentUser = PFUser.current()!

// getting potential buddies of users
let query1 = PFQuery(className: "author")
query1.whereKey("workoutLevel", equalTo: currentUser["workoutLevel"]!)
query1.includeKey("workoutPlan")
query1.limit = 10
query1.findObjectsInBackground { (potentialBuddies: [PFObject]?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let potentialBuddies = potentialBuddies {
        print("Successfully gather \(potentialBuddies.count) buddies")
    }
    
}

// getting current buddies of user
let query = PFQuery(className: "buddies")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.includeKey("workoutPlan")
query.findObjectsInBackground { (buddies: [PFObject]?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let buddies = buddies {
        print("Successfully gather \(buddies.count) buddies")
    }
    
}

// create new workout plan
let workoutPlan = PFObject(className: "workoutPlan")
workoutPlan["author"] = currentUser
workoutPlan["exercises"] = [1, 2, 3, 4, 5, 6] //integers representing specific exercises
workoutPlan.saveInBackground { (success, error) in
    if success {
        print("workout plan created")
    }
    else if let error = error {
        print(error.localizedDescription)
    }
}

// get workout plans
let query2 = PFQuery(className: "workoutPlan")
query2.limit = 20
query2.whereKey("workoutLevel", equalTo: currentUser["workoutLevel"]!)
query2.includeKey("author")
query2.findObjectsInBackground { (workoutPlans: [PFObject]?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let workoutPlans = workoutPlans {
        print("Successfully gather \(workoutPlans.count) plans")
    }
}

// create private message
let WHOMEVER_USER_IS_MESSAGING = "Some other user"
let post = PFObject(className: "chatMessage")
post["author"] = PFUser.current()
post["recipient"] = WHOMEVER_USER_IS_MESSAGING
post.saveInBackground { (success, error) in
    if success {
        print("post created")
    }
    else if let error = error {
        print(error.localizedDescription)
    }
}

// get private messages
let query3 = PFQuery(className: "chatMessage")
query3.limit = 20
query3.whereKey("author", equalTo: currentUser)
query3.whereKey("recipient", equalTo: WHOMEVER_USER_IS_MESSAGING)
query3.order(byDescending: "createdAt")
query3.findObjectsInBackground { (chatMessage: [PFObject]?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let chatMessage = chatMessage {
        print("Successfully gather \(chatMessage.count) messages")
    }
}

// delete workout plan
let query4 = PFQuery(className: "workoutPlan")
query4.whereKey("objectID", equalTo: "SOME ID")
query4.findObjectsInBackground {
    (plans: [PFObject]?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let plans = plans {
        for plan in plans {
            plan.delete()
        }
    }
}

// delete chat message
let query5 = PFQuery(className: "chatMessage")
query5.whereKey("author", equalTo: currentUser)
query5.whereKey("objectID", equalTo: "SOME ID")
query5.findObjectsInBackground {
    (messages: [PFObject]?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    }
    else if let messages = messages {
        for message in messages {
            message.delete()
        }
    }
}
