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
    @IBOutlet weak var sugguestionsCollectionView: UICollectionView!
    @IBOutlet weak var workoutsCollectionView: UICollectionView!

    var mates = [PFObject]()
    var otherWorkouts = [PFObject]()
    var currUser = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sugguestionsCollectionView.delegate = self
        sugguestionsCollectionView.dataSource = self
        
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
        sugguestionsCollectionView.reloadData()
    }
    
    func getWorkouts() {
        let query = PFQuery(className: "workoutPlan")
        query.limit = 20
        query.whereKey("author", notEqualTo: currUser)
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
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sugguestionsCollectionView {
            return mates.count
        }
        return otherWorkouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sugguestionsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomBuddyCell", for: indexPath) as! RandomBuddyCell
            let mate = mates[indexPath.row] as! PFUser
            
            cell.usernameLabel.text = mate.username
            cell.nameLabel.text = mate["name"] as? String
            cell.levelLabel.text = mate["workoutLevel"] as? String
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherWorkoutCell", for: indexPath) as! OtherWorkoutCell
        let routine = otherWorkouts[indexPath.row]
        
        let exercises = routine["exercises"] as! [[String]]
        let author = routine["author"] as! PFUser
        let date = routine["scheduledDate"] as? Date
        let level = routine["workoutLevel"] as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        let formattedDate = dateFormatter.string(from: date!)
        
        cell.nameLabel.text = routine["name"] as? String
        cell.dateLabel.text = formattedDate
        cell.numExercisesLabel.text = level
        cell.authorLabel.text = author.username
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 50
        let cellHeight = 128
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
