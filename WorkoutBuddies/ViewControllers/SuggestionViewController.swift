//
//  SuggestionViewController.swift
//  WorkoutBuddies
//
//  Created by Tiffany Lee on 12/10/20.
//

import UIKit
import Parse

class SuggestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mates = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        getMates()
    }
    
    func getMates() {
        let query = PFUser.query()
        query!.limit = 20
        let users = try! query?.findObjects()
        mates = users!
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionsCell", for: indexPath) as! SuggestionsCell
            let mate = mates[indexPath.row] as! PFUser
            
            cell.usernameLabel.text = mate.username
            cell.nameLabel.text = mate["name"] as? String
            cell.levelLabel.text = mate["workoutLevel"] as? String
            cell.backgroundColor = UIColor.lightGray
            
            return cell

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
