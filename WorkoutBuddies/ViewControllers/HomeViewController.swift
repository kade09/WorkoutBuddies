//
//  HomeViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 11/28/20.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController {
    @IBOutlet weak var suggestionsCollectionView: UICollectionView!
    @IBOutlet weak var workoutsCollectionView: UICollectionView!

    var mates = [PFObject]()
    var otherWorkouts = [PFObject]()
    var currUser = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        suggestionsCollectionView.delegate = self
        suggestionsCollectionView.dataSource = self
        
        workoutsCollectionView.delegate = self
        workoutsCollectionView.dataSource = self
        
        currUser = PFUser.current()!
        
        getMates()
        getWorkouts()
    }
    
    func getMates() {
        let query = PFUser.query()
        query!.limit = 20
        let users = try! query?.findObjects()
        mates = users!
        suggestionsCollectionView.reloadData()
    }
    
    func getWorkouts() {
        let currDate = Date()
        let query = PFQuery(className: "workoutPlan")
        query.limit = 20
        query.whereKey("author", notEqualTo: currUser)
        query.whereKey("scheduledDate", greaterThan: currDate)
        query.addDescendingOrder("scheduledDate")
        query.includeKey("author")
        query.findObjectsInBackground {(routines: [PFObject]?, error: Error?) in
            if let routines = routines {
                self.otherWorkouts = routines
                self.workoutsCollectionView.reloadData()
            }
            else if let error = error {
                print("error fetching home workouts")
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        sceneDelegate.window?.rootViewController = loginViewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chosenWorkoutSegue" {
            let cell = sender as! UICollectionViewCell
            let indexPath = workoutsCollectionView.indexPath(for: cell)!
            let routine = otherWorkouts[indexPath.row]
            
            let detailWorkout = segue.destination as! DetailWorkoutViewController
            detailWorkout.routine = routine
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == suggestionsCollectionView {
            return mates.count
        }else {
            return otherWorkouts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == suggestionsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomBuddyCell", for: indexPath) as! RandomBuddyCell
            let mate = mates[indexPath.row] as! PFUser
            
            cell.backgroundColor = UIColor.yellow
            cell.usernameLabel.text = mate.username
            cell.nameLabel.text = mate["name"] as? String
            cell.levelLabel.text = mate["workoutLevel"] as? String
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherWorkoutCell", for: indexPath) as! OtherWorkoutCell
            let routine = otherWorkouts[indexPath.row]
            
            let author = routine["author"] as! PFUser
            let date = routine["scheduledDate"] as? Date
            let level = routine["workoutLevel"] as? String
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            let formattedDate = dateFormatter.string(from: date!)
            
            cell.backgroundColor = UIColor.yellow
            cell.nameLabel.text = (routine["name"] as? String) ?? "Name Not Found"
            cell.dateLabel.text = formattedDate
            cell.levelLabel.text = level
            cell.authorLabel.text = author.username ?? "404 Not Found"
            //
            
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == suggestionsCollectionView {
//            let cellWidth = 130
//            let cellHeight = 128
            return CGSize(width: 130, height: 125)
        }else {
            return CGSize(width: 140, height: 140)
        }
       
    }
}
