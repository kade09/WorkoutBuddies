//
//  PlanCreationViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 12/3/20.
//

import UIKit
import Parse
import DropDown

protocol ExerciseDelegate {
    func addExercise(exercise: String)
}

class PlanCreationViewController: UIViewController {

    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scheduleDatePicker: UIDatePicker!
    
    var exercises = [[String]]()
    
    let verticalPullingExercises = [["Jumping Pull-Up", "Negative PullUp"], ["Pull-Up", "Chin-Up", "Wide PullUp", "Narrow PullUp"], ["L-Sit PullUp", "High PullUp", "Archer PullUp", "TyperWriter PullUp"]]
    let horizontalPullingExercises = [["Incline Row", "Horizontal Row"], ["Wide Row", "Tucked Front Lever", "Archer Rows"], ["Tucked Front Lever PullUp"]]
    let verticalPushingExercises = [["Parallel Bar Support Hold", "Negative Dip"], ["Dip", "Pike Pushup"], ["Ring Dip", "Bulgarian Ring Dip", "Elevated Pike Pushup"]]
    let horizontalPushingExercises = [["Incline Pushup", "Knee Pushup"], ["Pushup", "Diamond Pushup", "Decline Pushup"], ["Archer Pushup", "Rings Pushup", "RTO Pushup"]]
    let squatExercises = [["Squat"], ["Bulgarian Squat", "Cossack Squat"], ["Beginner Shrimp Squat", "Pistol Squat"]]
    let coreExercises = [["Plank"], ["Tucked Hanging Leg Raises", "Lying Leg Raises"], ["Pike Compressions", "V-Ups", "Tucked DragonFlag"]]
    let secCoreExercises = [["Reverse HyperExtension"],["Arch Raises", "Arch Body Hold"],["Arch Body Rocks"]]
    
    var beginnerRoutine = [[String]]()
    var intermediateRoutine = [[String]]()
    var advancedRoutine = [[String]]()
    
    var workoutLevel = ""
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        tableView.delegate = self
        tableView.dataSource = self
        scheduleDatePicker.minimumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        scheduleDatePicker.minuteInterval = 30
        
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseWorkoutLevel(_ sender: UIButton) {
        dropDown.dataSource = ["Beginner", "Intermediate", "Advanced"]
            dropDown.anchorView = sender
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
            dropDown.show()
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                guard let _ = self else {return}
                self!.workoutLevel = item
                self!.generateWorkout(level: item)
            sender.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func onCreatePlan(_ sender: Any) {
        tableView.reloadData()
        let author = PFUser.current()
        
        let routine = PFObject(className: "workoutPlan")
        routine["author"] = author
        routine["workoutName"] = workoutName.text
        routine["workoutLevel"] = workoutLevel
        routine["scheduledDate"] = scheduleDatePicker.date
        tableView.reloadData()
        routine["exercises"] = exercises
        
        routine.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            else if let error = error {
                print("error saving workout plan")
                print(error.localizedDescription)
            }
            
        }
    }
    
    func generateWorkout(level: String) {
        exercises.removeAll()
        switch level {
        case "Beginner":
            exercises.append([verticalPullingExercises[0][0], "3", "5"])
            exercises.append([horizontalPullingExercises[0][0], "3", "5"])
            exercises.append([verticalPushingExercises[0][0], "3","5"])
            exercises.append([horizontalPushingExercises[0][0], "3", "5"])
            exercises.append([squatExercises[0][0], "3", "5"])
            exercises.append([coreExercises[0][0], "3", "5"])
            exercises.append([secCoreExercises[0][0], "3", "5"])
            break
        case "Intermediate":
            exercises.append([verticalPullingExercises[1][0], "3", "5"])
            exercises.append([horizontalPullingExercises[1][0], "3", "5"])
            exercises.append([verticalPushingExercises[1][0], "3","5"])
            exercises.append([horizontalPushingExercises[1][0], "3", "5"])
            exercises.append([squatExercises[1][0], "3", "5"])
            exercises.append([coreExercises[1][0], "3", "5"])
            exercises.append([secCoreExercises[1][0], "3", "5"])

            break
        default:
            exercises.append([verticalPullingExercises[2][0], "3", "5"])
            exercises.append([horizontalPullingExercises[2][0], "3", "5"])
            exercises.append([verticalPushingExercises[2][0], "3","5"])
            exercises.append([horizontalPushingExercises[2][0], "3", "5"])
            exercises.append([squatExercises[2][0], "3", "5"])
            exercises.append([coreExercises[2][0], "3", "5"])
            exercises.append([secCoreExercises[2][0], "3", "5"])

            break
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondView = segue.destination as! ExerciseSelectionViewController
        secondView.delegate = self
    }
}

extension PlanCreationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if exercises.count == 0 || indexPath.row == exercises.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddExerciseCell")!

            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseCell
                
            cell.exerciseNameLabel.text = exercises[indexPath.row][0]
            exercises[indexPath.row][1] = cell.chooseSetsBtn.currentTitle ?? "1"
            exercises[indexPath.row][2] = cell.chooseRepsBtn.currentTitle ?? "1"
                
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension PlanCreationViewController: ExerciseDelegate {
    func addExercise(exercise: String) {
        exercises.append([exercise, "1", "1"])
        tableView.reloadData()
    }
}

