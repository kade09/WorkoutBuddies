//
//  ExerciseSelectionViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 12/3/20.
//
import UIKit

class ExerciseSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: ExerciseDelegate?
    
    var exercises = ["Bench Press", "Bicep Curl", "Ab Crunch", "Barbell Deadlift", "Pushup", "Pull-Up", "Chin-Up", "Squat", "Inverted Row"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PotentialExerciseCell") as! PotentialExerciseCell
        cell.exerciseLabel.text = exercises[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.addExercise(exercise: exercises.remove(at: indexPath.row))
        self.dismiss(animated: true, completion: nil)
    }
}
