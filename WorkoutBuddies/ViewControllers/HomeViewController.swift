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
   
    @IBOutlet weak var tableView: UITableView!

    var mates = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        getMates()
    }
    
    func getMates() {
        let query = PFUser.query()
        query!.limit = 20
        let users = try! query?.findObjects()
        mates = users!
        self.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mates.count == 0 || indexPath.row == mates.count {
            print("weofjweofo")
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreatePlanCell") as! CreatePlanCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatesCell") as! MatesCell
            
            let mate = mates[indexPath.row] as! PFUser
            
            cell.usernameLabel.text = mate.username
            
            cell.levelLabel.text = mate["level"] as? String
            
            return cell
        }
    }
}
