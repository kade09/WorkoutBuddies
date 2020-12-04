//
//  HomeViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 11/28/20.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("heeokfjewo")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCreatePlan(_ sender: Any) {
        self.performSegue(withIdentifier: "onCreatePlan", sender: nil)
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
