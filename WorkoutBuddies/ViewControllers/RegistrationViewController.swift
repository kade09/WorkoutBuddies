//
//  RegistrationViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 11/28/20.
//

import UIKit
import DropDown
import Parse

class RegistrationViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var workoutLevel: String!
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func tapChooseWorkoutLevel(_ sender: UIButton) {
        dropDown.dataSource = ["Beginner", "Intermediate", "Advanced"]
            dropDown.anchorView = sender
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
            dropDown.show()
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                guard let _ = self else {return}
                self!.workoutLevel = item
            sender.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreateAccount(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let name = nameTextField.text!
        
        let user = PFUser()
        user.username = username
        user.password = password
        user["name"] = name
        user["workoutLevel"] = workoutLevel
        
        user.signUpInBackground { (success, error) in
            if success {
                print("created account")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
            else if let error = error {
                print("problem signing in")
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
