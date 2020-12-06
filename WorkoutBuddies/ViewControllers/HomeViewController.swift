//
//  HomeViewController.swift
//  WorkoutBuddies
//
//  Created by Stephen Tan on 11/28/20.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatesCell") as! MatesCell
        
        let mate = mates[indexPath.row]
        
        let user = mate["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.levelLabel.text = mate["level"] as? String
        
        return cell
    }
    
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBAction func onCreatePlan(_ sender: Any) {
        self.performSegue(withIdentifier: "onCreatePlan", sender: nil)
    }
    
    var mates = [PFObject] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery (className: "Mates")
        query.includeKeys(["author"])
        query.limit = 20
        
        query.findObjectsInBackground { (mates,error) in
            if mates != nil {
                self.mates = mates!
                self.tableView.reloadData()
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
    }
}
