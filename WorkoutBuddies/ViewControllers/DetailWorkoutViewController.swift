//
//  DetailWorkoutViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 12/10/20.
//

import UIKit
import Parse

class DetailWorkoutViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var personJoinedLabel: UILabel!
    @IBOutlet weak var scheduledDate: UIDatePicker!
    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currUser: PFUser!
    var routine: PFObject!
    var exercises = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currUser = PFUser.current()!
        
        tableView.dataSource = self
        tableView.delegate = self
        
        scheduledDate.minimumDate = Date()
        scheduledDate.minuteInterval = 30
        
        scheduledDate.date = (routine["scheduledDate"] as? Date)!
        
        nameLabel.text = routine["workoutName"] as? String
        levelLabel.text = routine["workoutLevel"] as? String
        
        if let buddy = routine["buddy"] as? PFUser {
            personJoinedLabel.text = buddy.username
        }
        
        exercises = (routine["exercises"] as? [[String]])!
        
        tableView.reloadData()
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onRightBarButtone(_ sender: Any) {
    }
}

extension DetailWorkoutViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseCell
                       
        cell.exerciseNameLabel.text = exercises[indexPath.row][0]
        exercises[indexPath.row][1] = cell.chooseSetsBtn.currentTitle ?? "1"
        exercises[indexPath.row][2] = cell.chooseRepsBtn.currentTitle ?? "1"
                       
        return cell
    }
}
