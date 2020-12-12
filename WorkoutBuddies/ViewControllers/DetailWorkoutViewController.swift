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
    @IBOutlet weak var scheduledDateLabel: UILabel!
    @IBOutlet weak var personJoinedLabel: UILabel!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var routine: PFObject!
    var exercises = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
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
        return UITableViewCell()
    }
}
